-- ---@class RustAnalyzerConfig
-- ---@field assist Assist
-- ---@field cachepriming CachePriming
-- ---@field cargo Cargo
-- ---@field checkOnSave boolean
-- ---@field check Check
-- ---@field completion table
-- ---@field diagnostics table
-- ---@field files table
-- ---@field highlightRelated table
-- ---@field hover table
-- ---@field imports table
-- ---@field inlayHints table
-- ---@field interpret table
-- ---@field joinLines  table
-- ---@field lens table
-- ---@field linkedProjects string[]
-- ---@field lru table
-- ---@field notifications table
-- ---@field numThreads integer|nil
-- ---@field procMacro table
-- ---@field references table
-- ---@field rename table
-- ---@field runnables table
-- ---@field rust table
-- ---@field rustc table
-- ---@field rustfmt table|nil
-- ---@field semanticHighlighting table
-- ---@field signatureInfo table
-- ---@field typing table
-- ---@field workspace table
--
--
-- ---@class Assist
-- ---@field emitMustUse boolean
-- ---@field expressionFillDefault string
--
--
-- ---@class CachePriming
-- ---@field enable boolean
--
-- ---@class Cargo
-- ---@field autoreload boolean
-- ---@field buildScripts table
-- ---@field cfgs string[]
-- ---@field extraArgs string[]
-- ---@field extraEnv string[]
-- ---@field features? string[]|string
-- ---@field noDefaultFeatures boolean
-- ---@field sysroot string
-- ---@field sysrootQueryMetadata boolean
-- ---@field sysrootSrc string|nil
-- ---@field target string|nil
-- ---@field unsetTest string[]
--
--
-- ---@class Check
-- ---@field allTargets boolean
-- ---@field targets string|string[]|nil
-- ---@field command string
-- ---@field extraArgs string[]
