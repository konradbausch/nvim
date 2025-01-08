return {
  "seblj/roslyn.nvim",
  ft = "cs",
  version = "*",
  opts = {
    filewatching = false, -- Improves performance
    config = {
      settings = {
        ["csharp|background_analysis"] = {
          -- Only analyze open files for better performance
          dotnet_analyzer_diagnostics_scope = "fullSolution",
          dotnet_compiler_diagnostics_scope = "fullSolution"
        }
      }
    }
  }
}
