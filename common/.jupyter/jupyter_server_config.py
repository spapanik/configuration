from pathlib import Path

state = Path.home() / ".local/state/jupyter/checkpoints"
state.mkdir(parents=True, exist_ok=True)

c.FileCheckpoints.checkpoints_dir = str(state)
c.JupyterApp.answer_yes = True
