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

      local servers = { "lua_ls", "rust_analyzer", "nil_ls", "tsserver", "pyright" }
      for _, s in ipairs(servers) do
        if lspconfig[s] then
          lspconfig[s].setup({ capabilities = capabilities, on_attach = on_attach })
        end
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
    pyright
  ];
}
