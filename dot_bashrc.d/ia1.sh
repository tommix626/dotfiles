# ia1-only additions (sourced by ~/.bashrc)

alias l='ls -lh'
alias nv='nvidia-smi'
alias scrc='source ~/.bashrc'
alias ducwd='du -sh * | sort -h'
alias cls='clear'

export SLURM_GRID_SETUP="-A ia1 --partition=debug --qos=normal"

alias reqgpu="salloc $SLURM_GRID_SETUP --gres=gpu:1 srun --pty bash -i"
alias req2gpu="salloc $SLURM_GRID_SETUP --gres=gpu:2 srun --pty bash -i"
alias req4gpu="salloc $SLURM_GRID_SETUP --gres=gpu:4 srun --pty bash -i"
alias req8gpu="salloc $SLURM_GRID_SETUP --gres=gpu:8 srun --pty bash -i"

alias qstata='squeue --format "%9i %40j %2t %8M %9P %4C %8f %7m %5D %16R %.8u"'
alias qstat='squeue --format "%9i %40j %2t %8M %9P %4C %8f %7m %5D %16R %.8u" -u $USER'
alias showjob='scontrol show jobid -d'

qscount() {
  local c
  c=$(qstat | wc -l)
  echo $((c-1))
}

export TERM=xterm-256color
export PATH="$HOME/.local/bin:$PATH"

# Default env on ia1 (keep if you want it)
conda activate llm-memory-clean 2>/dev/null || true
