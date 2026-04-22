#!/usr/bin/env bash

sed -i '/static getInfo/,/^  }/c\  static getInfo(force = false) { if (FFMPEG.command && !force) return FFMPEG;FFMPEG.command = "ffmpeg"; const result = ChildProcess.spawnSync("ffmpeg", ["-h"], { windowsHide: true }); FFMPEG.output = Buffer.concat(result.output.filter(Boolean)).toString(); return FFMPEG; }' node_modules/prism-media/src/core/FFmpeg.js
sed -i "/^const loader = require('\.\.\/util\/loader');/,/^}$/c\const { OpusEncoder } = require('@discordjs/opus/prebuild/node-v127-napi-v3-linux-x64-glibc-2.39/opus.node');let Opus = { Encoder: OpusEncoder, name: '@discordjs/opus' };function loadOpus(refresh = false) { return Opus; }" node_modules/prism-media/src/opus/Opus.js
sed -i 's/var WebSocketConstructor = (0, import_util2\.shouldUseGlobalFetchAndWebSocket)() ? globalThis\.WebSocket : import_ws\.WebSocket;/var WebSocketConstructor = globalThis.WebSocket;/' node_modules/@discordjs/ws/dist/index.js
sed -i 's/import_ws\.WebSocket/globalThis.WebSocket/g' node_modules/@discordjs/ws/dist/index.js
sed -i 's/this\.ws = new import_ws\.default(address);/this.ws = new globalThis.WebSocket(address);/' node_modules/@discordjs/voice/dist/index.js
sed -i '/var import_ws = require("ws");/d' node_modules/@discordjs/ws/dist/index.js
sed -i '/var import_ws = __toESM(require("ws"));/d' node_modules/@discordjs/voice/dist/index.js
