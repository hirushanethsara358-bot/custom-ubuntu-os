#!/bin/bash
# CrewAI Multi-Agent Framework Setup for Custom Ubuntu OS
set -e

echo "=== Installing CrewAI & Multi-Agent Development Environment ==="

# 1. Update and install Python, pip, python3-venv, and build tools
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    git \
    curl

# 2. Create a global CrewAI environment or pip install crewai
echo "Installing CrewAI and essential LLM agent packages..."
python3 -m pip install --no-cache-dir --upgrade pip
python3 -m pip install --no-cache-dir \
    crewai \
    crewai-tools \
    langchain \
    openai \
    anthropic \
    requests \
    streamlit

# 3. Create a sample CrewAI demo project in skeleton directory so every user gets it
DEMO_DIR="/etc/skel/CrewAI-Demo"
mkdir -p "$DEMO_DIR"

cat << 'EOF' > "$DEMO_DIR/agent_demo.py"
#!/usr/bin/env python3
"""
Sample CrewAI Multi-Agent Script pre-installed on macOS Ubuntu Edition.
"""
import os
from crewai import Agent, Task, Crew, Process

print("=== CrewAI Multi-Agent System Initialized ===")
print("Python Environment is fully prepared for AI Agents!")

# Example Agent setup (requires OPENAI_API_KEY to execute tasks)
# researcher = Agent(
#     role='Senior Research Analyst',
#     goal='Uncover cutting-edge developments in AI',
#     backstory='You are an expert analyst with an eye for detail.',
#     verbose=True
# )
EOF

chmod +x "$DEMO_DIR/agent_demo.py"

echo "CrewAI multi-agent environment successfully installed and configured!"
