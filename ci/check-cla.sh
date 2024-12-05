#!/usr/bin/env bash
set -eux

AUTHOR="$1"
echo "Pull request submitted by $AUTHOR";
URL_AUTHOR=$(jq -rn --arg x "$AUTHOR" '$x|@uri')
signed=$(curl -s "https://contribute.akka.io/contribute/cla/scala/check/$URL_AUTHOR" | jq -r ".signed");
if [ "$signed" = "true" ] ; then
  echo "CLA check for $AUTHOR successful";
else
  echo "CLA check for $AUTHOR failed";
  echo "Please sign the Scala CLA to contribute to Scala.js.";
  echo "Go to https://contribute.akka.io/contribute/cla/scala and then";
  echo "comment on the pull request to ask for a new check.";
  exit 1;
fi;
