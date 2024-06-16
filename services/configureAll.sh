#/bin/bash
echo "Wanna install or uninstall ALL (this script is idempotent)? (i/u)"
read action
if [ $action != "i" ] && [ $action != "u" ]; then
  echo "Invalid action"
  exit 1
fi
cd metalLB/
./configure.sh $action
cd ../argo-cd
./configure.sh $action
cd ../grafana-prometheus
./configure.sh $action

