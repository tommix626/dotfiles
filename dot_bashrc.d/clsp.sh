# CLSP helpers / aliases (no secrets)

# convenience
alias tf='tail -f'
alias sq='squeue -u $USER'
alias wsq='watch -n 0.5 squeue -u $USER'
alias cnt='srun --pty bash -l'

# terminal
export TERM=xterm-256color

# better sinfo view
alias sinfo_long='sinfo -O "Partition:.10,Available:.6,Time:.11,Nodes:.5,StateLong:12,Gres,GresUsed:24,CPUsState,CPUsLoad,AllocMem,Memory,FreeMem,NodeList" | less -SN'

# GPU allocation helper
gpu() {
  local gpus=${1:-1}
  local t=${2:-3}

  if [[ "$t" =~ ^[0-9]+$ ]]; then
    t=$(printf "%02d:00:00" "$t")
  fi

  echo "Requesting $gpus GPU(s) for $t..."
  salloc -p gpu --gpus=$gpus --time=$t srun --pty bash
}

# Connect to first RUNNING job for current user
connect() {
  local jobid
  jobid=$(squeue -u "$USER" -h -t RUNNING -o "%i" | head -n 1)

  if [[ -z "$jobid" ]]; then
    echo "❌ No running jobs found."
    return 1
  fi

  echo "✅ Connecting to job $jobid ..."
  srun --jobid="$jobid" --pty bash
}

connectid() {
  srun --jobid "$1" --pty bash -l
}

# Dangerous convenience: cancel all jobs (kept, but safer prompt)
cancel_all_jobs() {
  read -p "Cancel all jobs for user $USER? [y/N] " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    scancel -u "$USER"
  else
    echo "Skipped."
  fi
}
alias sc='cancel_all_jobs'
alias reqgpu='salloc --partition=gpu-a100 --account=a100acct --gpus=1 --time=6:00:00'
