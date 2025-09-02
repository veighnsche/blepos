{ config, pkgs, lib, ... }:
{
  # Core Neovim setup managed by Home Manager
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Useful extra binaries available inside Neovim runtime (e.g., for Telescope)
    extraPackages = with pkgs; [
      ripgrep
      fd
      tree-sitter
    ];

    # Plugins from nixpkgs
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      gruvbox-nvim
      telescope-nvim
      nvim-treesitter
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      lualine-nvim
      gitsigns-nvim
      comment-nvim

      # JS/TS/React specific niceties
      nvim-ts-autotag
      conform-nvim
      typescript-tools-nvim
    ];

    # Lightweight Lua config (you can move this to a file and use builtins.readFile later)
    extraLuaConfig = ''
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.termguicolors = true

      pcall(vim.cmd.colorscheme, "gruvbox")

      -- Plugins setup
      require("telescope").setup({})
      require("gitsigns").setup({})
      require("lualine").setup({ options = { theme = "gruvbox" }})
      require("comment").setup({})

      -- Treesitter
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- LSP basics
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      -- Core servers (adjust to taste)
      local servers = { "lua_ls", "rust_analyzer", "nil_ls", "pyright", "html", "cssls", "jsonls" }
      for _, s in ipairs(servers) do
        if lspconfig[s] then
          lspconfig[s].setup({ capabilities = capabilities, on_attach = on_attach })
        end
      end

      -- TypeScript via typescript-tools (better UX for TS than plain tsserver)
      local ok_tstools, tstools = pcall(require, "typescript-tools")
      if ok_tstools then
        tstools.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Let formatter handle formatting (prettier/biome)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
          end,
          settings = {
            tsserver_file_preferences = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeCompletionsForModuleExports = true,
            },
          },
        })
      elseif lspconfig.tsserver then
        lspconfig.tsserver.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
          end,
        })
      end

      -- Tailwind CSS
      if lspconfig.tailwindcss then
        lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })
      end

      -- Completion
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      -- Auto tag for React/TSX/HTML
      pcall(require, "nvim-ts-autotag").setup()

      -- Formatting via conform.nvim (uses available formatters: prettierd, prettier, biome)
      local ok_conform, conform = pcall(require, "conform")
      if ok_conform then
        conform.setup({
          formatters_by_ft = {
            javascript = { "biome", "prettierd", "prettier" },
            javascriptreact = { "biome", "prettierd", "prettier" },
            typescript = { "biome", "prettierd", "prettier" },
            typescriptreact = { "biome", "prettierd", "prettier" },
            json = { "biome", "prettierd", "prettier" },
            css = { "prettierd", "prettier" },
            html = { "prettierd", "prettier" },
            markdown = { "prettierd", "prettier" },
          },
          format_on_save = function(bufnr)
            local disabled = vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat
            if disabled then return end
            return { timeout_ms = 2000, lsp_fallback = true }
          end,
        })
        -- Toggle format on save
        vim.api.nvim_create_user_command("FormatDisable", function() vim.g.disable_autoformat = true end, {})
        vim.api.nvim_create_user_command("FormatEnable", function() vim.g.disable_autoformat = false end, {})
      end
    '';
  };

  # Useful CLI tools Neovim/Telescope commonly expects
  home.packages = with pkgs; [
    ripgrep
    fd
    unzip

    # Language servers and related tools (adjust to taste)
    lua-language-server
    rust-analyzer
    nil  # nix LSP (nil_ls)
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.vscode-langservers-extracted # html, css, json
    nodePackages."@tailwindcss/language-server"
    pyright

    # JS tooling
    bun
    biome
    prettierd
    eslint_d
  ];
}
