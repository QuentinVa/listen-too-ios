#!/bin/sh

# Go to git repo root level
cd $(git rev-parse --show-toplevel)

if [[ "$BUILD_DIR" == *"IBDesignables"* ]] || [[ "$BUILD_DIR" == *"Previews"* ]] || [[ -n "$DISABLE_SWIFTLINT" ]]; then
    echo "not linting for IBDesignables/SwiftUI Previews builds";
    exit 0
fi

SWIFT_LINT="$(ls -1 $HOME/Library/Developer/Xcode/DerivedData/ListenToo-*/SourcePackages/artifacts/swiftlintplugins/SwiftLintBinary/SwiftLintBinary.artifactbundle/swiftlint-*macos/bin/swiftlint 2>/dev/null)"
if [[ -z $SWIFT_LINT ]] ; then
    echo "warning: SwiftLint not found in DerivedData, using system provided if installed"
    SWIFT_LINT=$(which swiftlint)
fi

if [[ -z $SWIFT_LINT ]] ; then
    echo "warning: SwiftLint not installed, please download it from https://github.com/realm/SwiftLint"
    exit 0
fi

if [[ "$(ps -p $PPID)" != *".build"* ]] ; then
    # runs out of Xcode 
    RUN_CLANG_STATIC_ANALYZER=YES # force linting all files
    # ./scripts/swiftlint.sh install-hook
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

if [[ $RUN_CLANG_STATIC_ANALYZER == "YES" ]] ; then # allows to lint all files via Xcode, menu Build -> Analyse
    echo "Linting all swift files"
    $SWIFT_LINT --strict --quiet 2>/dev/null
    exit $?
else
    echo "Linting only git modified/changed swift files"
    COUNT=0
    
    ##### Check for modified git files #####
    FILES=$(git diff --name-only --diff-filter=d | grep -iv "^vendor" | grep ".swift$")
    if [ ! -z "$FILES" ]; then
        while read FILE_PATH; do
            export SCRIPT_INPUT_FILE_$COUNT=$FILE_PATH
            COUNT=$((COUNT + 1))
        done <<< "$FILES"
    fi

    ##### Check for modified files in unstaged/Staged area #####
    FILES=$(git diff --name-only --cached --diff-filter=d | grep -iv "^vendor"  | grep ".swift$")
    if [ ! -z "$FILES" ]; then
        while read FILE_PATH; do
            export SCRIPT_INPUT_FILE_$COUNT=$FILE_PATH
            COUNT=$((COUNT + 1))
        done <<< "$FILES"
    fi

    ##### Make the count avilable as global variable #####
    export SCRIPT_INPUT_FILE_COUNT=$COUNT
    env | grep SCRIPT_INPUT_FILE_

    if [[ $COUNT -ne 0 ]] ; then
        $SWIFT_LINT --use-script-input-files --quiet 2>/dev/null
    fi
fi
