const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Allow overriding the config path via an environment variable, or default to ./config.json
const configPath = process.env.MCP_CONFIG_PATH || path.join(__dirname, 'config.json');
const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));

const servers = config.mcpServers;

for (const [name, serverConfig] of Object.entries(servers)) {
  const command = serverConfig.command;
  const args = serverConfig.args || [];
  const env = { ...process.env, ...serverConfig.env };

  console.log(`Starting MCP server: ${name}`);
  const proc = spawn(command, args, { env, stdio: 'inherit' });

  proc.on('close', (code) => {
    console.log(`Server ${name} exited with code ${code}`);
  });
}
