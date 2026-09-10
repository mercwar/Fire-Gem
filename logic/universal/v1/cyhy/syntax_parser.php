<?php
/**
 * AVIS Core v1 - CYHY Syntax Lexer & Parser
 */

namespace Cyhy\AvisEditor;

class SyntaxParser {
    private array $tokens = [];
    private int $position = 0;

    public function tokenize(string $sourceCode): array {
        $lines = explode("\n", $sourceCode);
        foreach ($lines as $lineNum => $line) {
            $line = trim($line);
            if (empty($line)) continue;

            // Handle comment stripping or comment tokens
            if (str_starts_with($line, '#') || str_starts_with($line, '//')) {
                $this->tokens[] = ['type' => 'T_COMMENT', 'value' => $line, 'line' => $lineNum];
                continue;
            }

            // Simple lexical matching patterns for AVIS Core
            if (preg_match('/^(DECL_HOOK_MODULE|BIND_TARGET_AXIS|CHECK_ENV_TOKEN|ROUTE_ORCHESTRATION_INPUT|EXECUTE_BRIDGE_SUBROUTINE|INJECT_MAPPED_CONTEXT|SYNCHRONIZE_PIPELINE_COMPLETE|LOG_METRIC_STATE)\b/', $line, $matches)) {
                $this->tokens[] = ['type' => 'T_KEYWORD', 'value' => $matches[0], 'line' => $lineNum];
                $line = trim(substr($line, strlen($matches[0])));
            }

            if (!empty($line)) {
                $this->tokens[] = ['type' => 'T_EXPRESSION', 'value' => $line, 'line' => $lineNum];
            }
        }
        return $this->tokens;
    }

    public function validateStructure(): bool {
        if (empty($this->tokens)) return false;
        
        // Ensure standard entry module format matching rules.bnf
        if ($this->tokens[0]['type'] !== 'T_KEYWORD' || $this->tokens[0]['value'] !== 'DECL_HOOK_MODULE') {
            error_log("Parser Error: Missing DECL_HOOK_MODULE header configuration statement.");
            return false;
        }
        
        return true;
    }
}
