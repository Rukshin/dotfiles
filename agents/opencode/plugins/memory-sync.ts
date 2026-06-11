/**
 * memory-sync — OpenCode plugin
 *
 * Syncs Engram memory to the Obsidian vault whenever a real session ends.
 * Equivalent to the Claude Code `Stop` hook:
 *   ~/.dotfiles/scripts/ai/memory-sync ~/Code/mine/pkm/x
 *
 * This file is intentionally separate from engram.ts (which is owned by
 * the gentle-ai plugin and gets overwritten on upgrades).
 */

import type { Plugin } from "@opencode-ai/plugin"

const ENGRAM_BIN = process.env.ENGRAM_BIN ?? Bun.which("engram") ?? "/opt/homebrew/bin/engram"
const VAULT_PATH = `${process.env.HOME}/Code/mine/pkm/x`

// Sub-agent sessions (created via Task()) must not trigger a vault sync.
// We detect them the same way engram.ts does: parentID set or title ending in " subagent)".
const subAgentSessions = new Set<string>()

export const MemorySync: Plugin = async (_ctx) => {
  return {
    event: async ({ event }) => {
      // Track sub-agent sessions so we can skip them on delete
      if (event.type === "session.created") {
        const info = (event.properties as any)?.info
        const sessionId: string | undefined = info?.id
        const parentID = info?.parentID
        const title: string = info?.title ?? ""
        if (sessionId && (!!parentID || title.endsWith(" subagent)"))) {
          subAgentSessions.add(sessionId)
        }
      }

      if (event.type === "session.deleted") {
        const info = (event.properties as any)?.info
        const sessionId: string | undefined = info?.id
        if (!sessionId) return

        const isSubAgent = subAgentSessions.has(sessionId)
        subAgentSessions.delete(sessionId)
        if (isSubAgent) return

        // Resolve GH token (engram update check needs it)
        let ghToken = ""
        try {
          const result = Bun.spawnSync(["gh", "auth", "token", "--hostname", "github.com"])
          if (result.exitCode === 0) ghToken = result.stdout?.toString().trim() ?? ""
        } catch {}

        // Fire-and-forget: mirror of ~/.dotfiles/scripts/ai/memory-sync
        try {
          Bun.spawn([ENGRAM_BIN, "obsidian-export", "--vault", VAULT_PATH], {
            stdout: "ignore",
            stderr: "ignore",
            stdin: "ignore",
            env: { ...process.env, GH_TOKEN: ghToken, GITHUB_TOKEN: ghToken },
          })
        } catch {
          // Binary not found or vault path invalid — silently skip
        }
      }
    },
  }
}
