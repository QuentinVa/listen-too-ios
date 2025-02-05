#!/bin/sh

# Se déplacer à la racine du dépôt git
cd $(git rev-parse --show-toplevel)

# Vérifier si le build est pour IBDesignables, les Previews SwiftUI ou si le linting est désactivé
if [[ "$BUILD_DIR" == *"IBDesignables"* ]] || [[ "$BUILD_DIR" == *"Previews"* ]] || [[ -n "$DISABLE_SWIFTLINT" ]]; then
    echo "not linting for IBDesignables/SwiftUI Previews builds";
    exit 0
fi

# Localiser SwiftLint dans le dossier DerivedData
SWIFT_LINT="$(ls -1 $HOME/Library/Developer/Xcode/DerivedData/ListenToo-*/SourcePackages/artifacts/swiftlintplugins/SwiftLintBinary/SwiftLintBinary.artifactbundle/swiftlint-*macos/bin/swiftlint 2>/dev/null)"

# Si SwiftLint n'est pas trouvé dans DerivedData, essayer de l'utiliser depuis le système
if [[ -z $SWIFT_LINT ]] ; then
    echo "warning: SwiftLint not found in DerivedData, using system provided if installed"
    SWIFT_LINT=$(which swiftlint)
fi

# Si SwiftLint n'est toujours pas trouvé, afficher un avertissement et quitter
if [[ -z $SWIFT_LINT ]] ; then
    echo "warning: SwiftLint not installed, please download it from https://github.com/realm/SwiftLint"
    exit 0
fi

# Vérifier si le script est exécuté hors d'Xcode
if [[ "$(ps -p $PPID)" != *".build"* ]] ; then
    # Forcer le linting de tous les fichiers
    RUN_CLANG_STATIC_ANALYZER=YES
    
    # Installer un hook de pré-commit si demandé
    if [ -n "$1" ] && [ "$1" = "install-hook" ] ; then
        echo "Installing pre-commit hook : "
        cd .git/hooks
        ln -sf ../../scripts/swiftlint.sh pre-commit
        cd -
        ls .git/hooks/pre-commit
        exit 0
    fi
fi

echo "Using swiftlint at $SWIFT_LINT"

# Si RUN_CLANG_STATIC_ANALYZER est activé, linter tous les fichiers Swift
if [[ $RUN_CLANG_STATIC_ANALYZER == "YES" ]] ; then
    echo "Linting all swift files"
    $SWIFT_LINT --strict --quiet 2>/dev/null
    exit $?
else
    echo "Linting only git modified/changed swift files"
    COUNT=0
    
    ##### Vérifier les fichiers modifiés dans git #####
    FILES=$(git diff --name-only --diff-filter=d | grep -iv "^vendor" | grep ".swift$")
    if [ ! -z "$FILES" ]; then
        while read FILE_PATH; do
            export SCRIPT_INPUT_FILE_$COUNT=$FILE_PATH
            COUNT=$((COUNT + 1))
        done <<< "$FILES"
    fi

    ##### Vérifier les fichiers modifiés en staging #####
    FILES=$(git diff --name-only --cached --diff-filter=d | grep -iv "^vendor"  | grep ".swift$")
    if [ ! -z "$FILES" ]; then
        while read FILE_PATH; do
            export SCRIPT_INPUT_FILE_$COUNT=$FILE_PATH
            COUNT=$((COUNT + 1))
        done <<< "$FILES"
    fi

    ##### Rendre le nombre de fichiers disponible comme variable globale #####
    export SCRIPT_INPUT_FILE_COUNT=$COUNT
    env | grep SCRIPT_INPUT_FILE_

    # Lancer SwiftLint uniquement si des fichiers ont été modifiés
    if [[ $COUNT -ne 0 ]] ; then
        $SWIFT_LINT --use-script-input-files --quiet 2>/dev/null
    fi
fi