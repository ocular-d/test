#!/usr/bin/env bash
# Checks CHANGELOG.md for double versions
set -o pipefail

ERRORCODE=0

# Ensure that the CHANGELOG.md does not contain duplicate versions
DUPLICATE_CHANGELOG_VERSIONS=$(grep --extended-regexp '^## .+' CHANGELOG.md | grep -oP '\[\K[^]]+' | sort -r | uniq -d)
echo '=> Checking for CHANGELOG.md duplicate entries...'
echo
if [ "${DUPLICATE_CHANGELOG_VERSIONS}" != "" ]
then
  echo '✖ ERROR: Duplicate versions in CHANGELOG.md:' >&2
  echo "${DUPLICATE_CHANGELOG_VERSIONS}" >&2
  RESULT="✖ ${ERRORCODE} ✖ ERROR: Duplicate versions in CHANGELOG.md"
  echo ::set-output name=result::"$RESULT"
  exit 1
  ((ERRORCODE++))
fi