
const mineflayer = require('mineflayer');
const { GoalFollow } = require('mineflayer-pathfinder').goals;

const god_commands = {
    executeCommand: {
        name: 'executeCommand',
        description: 'Execute a Minecraft command. Provide the command to execute, without the initial slash.',
        examples: [
            {
                "arguments": {
                    "command": "time set day"
                }
            },
            {
                "arguments": {
                    "command": "tp player1 100 64 200"
                }
            }
        ],
        perform: async (bot, command) => {
            bot.chat(`/${command}`);
            return `Command executed: /${command}`;
        }
    },
    followPlayer: {
        name: 'followPlayer',
        description: 'Follow a player continuously.',
        examples: [
            {
                "arguments": {
                    "username": "player1"
                }
            }
        ],
        perform: async (bot, username) => {
            const target = bot.players[username]?.entity;
            if (!target) {
                return `Player ${username} not found.`;
            }
            bot.pathfinder.setGoal(new GoalFollow(target, 1), true);
            return `Following ${username}.`;
        }
    },
    stop: {
        name: 'stop',
        description: 'Stop the current action, such as following a player.',
        examples: [
            {
                "arguments": {}
            }
        ],
        perform: async (bot) => {
            bot.pathfinder.stop();
            return 'Stopped current action.';
        }
    }
};

module.exports = god_commands;
