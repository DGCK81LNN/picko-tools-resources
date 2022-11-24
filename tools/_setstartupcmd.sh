#!/usr/bin/env bash
echo "$(s 93)Input startup commands, Ctrl+C to cancel, Ctrl+D to save$(s)"
trap 'echo "$(s 30 101) Canceled $(s)"; echo ""; exit 130' SIGINT
cat > ../game/_start.txt && (
  echo "$(s 30 102) Saved $(s)"
  sample=$(head -c50 ../game/_start.txt)
  _utils/cverlog "startup commands: [${sample//$'\n'/; }]"
)
