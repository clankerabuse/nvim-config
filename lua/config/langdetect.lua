local M = {}

---@class LanguageDetect
---@field files string[] Glob patterns that indicate this language
---@field extras string[] LazyVim extra import paths to enable
---@field plugins table[]|nil Optional plugin specs to add

M.languages = {
  {
    files = { "package.json", "*.ts", "*.tsx", "*.js", "*.jsx", "*.mjs", "*.cjs", "tsconfig.json", "jsconfig.json", "*.mts", "*.cts" },
    extras = {
      "lazyvim.plugins.extras.lang.typescript",
      "lazyvim.plugins.extras.lang.json",
    },
  },
  {
    files = { "*.vue", "vue.config.*" },
    extras = { "lazyvim.plugins.extras.lang.vue" },
  },
  {
    files = { "*.svelte", "svelte.config.*" },
    extras = { "lazyvim.plugins.extras.lang.svelte" },
  },
  {
    files = { "*.astro", "astro.config.*" },
    extras = { "lazyvim.plugins.extras.lang.astro" },
  },
  {
    files = { "angular.json", "*.component.ts" },
    extras = { "lazyvim.plugins.extras.lang.angular" },
  },
  {
    files = { "*.go", "go.mod", "go.sum" },
    extras = { "lazyvim.plugins.extras.lang.go" },
  },
  {
    files = { "*.rs", "Cargo.toml", "Cargo.lock" },
    extras = { "lazyvim.plugins.extras.lang.rust" },
  },
  {
    files = { "*.py", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "*.ipynb", "tox.ini" },
    extras = {
      "lazyvim.plugins.extras.lang.python",
      "lazyvim.plugins.extras.formatting.black",
    },
  },
  {
    files = { "*.java", "pom.xml", "build.gradle", "build.gradle.kts", "gradlew", "*.kt", "*.kts" },
    extras = { "lazyvim.plugins.extras.lang.java" },
  },
  {
    files = { "*.cpp", "*.cc", "*.cxx", "*.hpp", "*.h", "*.hh", "CMakeLists.txt", "*.cmake" },
    extras = {
      "lazyvim.plugins.extras.lang.clangd",
      "lazyvim.plugins.extras.lang.cmake",
    },
  },
  {
    files = { "*.cs", "*.csproj", "*.sln", "*.fs", "*.fsproj" },
    extras = { "lazyvim.plugins.extras.lang.dotnet" },
  },
  {
    files = { "*.kt", "*.kts", "build.gradle.kts" },
    extras = { "lazyvim.plugins.extras.lang.kotlin" },
  },
  {
    files = { "*.scala", "*.sc", "build.sbt" },
    extras = { "lazyvim.plugins.extras.lang.scala" },
  },
  {
    files = { "*.ex", "*.exs", "mix.exs", "mix.lock" },
    extras = { "lazyvim.plugins.extras.lang.elixir" },
  },
  {
    files = { "*.rb", "Gemfile", "Rakefile", "*.gemspec" },
    extras = { "lazyvim.plugins.extras.lang.ruby" },
  },
  {
    files = { "*.php", "composer.json", "composer.lock" },
    extras = { "lazyvim.plugins.extras.lang.php" },
  },
  {
    files = { "*.zig", "build.zig" },
    extras = { "lazyvim.plugins.extras.lang.zig" },
  },
  {
    files = { "*.nix", "flake.nix", "flake.lock", "shell.nix", "default.nix" },
    extras = { "lazyvim.plugins.extras.lang.nix" },
  },
  {
    files = { "*.tf", "*.tfvars", "*.hcl", "main.tf" },
    extras = { "lazyvim.plugins.extras.lang.terraform" },
  },
  {
    files = { "*.sql", "*.ddl", "*.dml", "*.sqlite", "docker-compose*.yml", "docker-compose*.yaml" },
    extras = { "lazyvim.plugins.extras.lang.sql" },
  },
  {
    files = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml", ".dockerignore" },
    extras = { "lazyvim.plugins.extras.lang.docker" },
  },
  {
    files = { "*.md", "*.mdx", "*.markdown", "README.md", "CHANGELOG.md", "CONTRIBUTING.md" },
    extras = { "lazyvim.plugins.extras.lang.markdown" },
  },
  {
    files = { "*.yaml", "*.yml", ".github/**/*.yml", ".github/**/*.yaml" },
    extras = { "lazyvim.plugins.extras.lang.yaml" },
  },
  {
    files = { "*.json", "*.jsonc", "*.geojson", "package.json" },
    extras = { "lazyvim.plugins.extras.lang.json" },
  },
  {
    files = { "*.toml", "Cargo.toml", "pyproject.toml", "poetry.toml" },
    extras = { "lazyvim.plugins.extras.lang.toml" },
  },
  {
    files = { "*.graphql", "*.gql", "schema.graphql" },
    extras = { "lazyvim.plugins.extras.lang.graphql" },
  },
  {
    files = { "*.prisma", "prisma/schema.prisma" },
    extras = { "lazyvim.plugins.extras.lang.prisma" },
  },
  {
    files = { "*.css", "*.scss", "*.sass", "*.less", "tailwind.config.*", "postcss.config.*", "*.html", "*.htm", "*.html.erb" },
    extras = { "lazyvim.plugins.extras.lang.tailwind" },
  },
  {
    files = { "*.nu" },
    extras = { "lazyvim.plugins.extras.lang.nushell" },
  },
  {
    files = { "*.ml", "*.mli", "dune", "dune-project" },
    extras = { "lazyvim.plugins.extras.lang.ocaml" },
  },
  {
    files = { "*.hs", "stack.yaml", "cabal.project", "*.cabal" },
    extras = { "lazyvim.plugins.extras.lang.haskell" },
  },
  {
    files = { "*.dart", "pubspec.yaml" },
    extras = { "lazyvim.plugins.extras.lang.dart" },
  },
  {
    files = { "*.twig" },
    extras = { "lazyvim.plugins.extras.lang.twig" },
  },
  {
    files = { "*.tex", "*.sty", "*.cls" },
    extras = { "lazyvim.plugins.extras.lang.tex" },
  },
  {
    files = { "*.thrift" },
    extras = { "lazyvim.plugins.extras.lang.thrift" },
  },
  {
    files = { "*.gitconfig", ".gitmodules", "*.gitignore" },
    extras = { "lazyvim.plugins.extras.lang.git" },
  },
}

local root_markers = {
  ".git",
  ".hg",
  ".svn",
  "package.json",
  "go.mod",
  "Cargo.toml",
  "pyproject.toml",
  "setup.py",
  "Gemfile",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "CMakeLists.txt",
  "flake.nix",
  "mix.exs",
  "angular.json",
  "docker-compose.yml",
  "docker-compose.yaml",
  "tailwind.config.js",
  "tailwind.config.ts",
  "tsconfig.json",
  "jsconfig.json",
  "Cargo.lock",
  "composer.json",
  "build.zig",
}

local function get_project_root()
  local cwd = vim.uv.cwd()
  local path = cwd

  while path and path ~= "/" do
    for _, marker in ipairs(root_markers) do
      if marker:find("/") then
        -- glob-style marker
        local glob = path .. "/" .. marker
        local matches = vim.fn.glob(glob, true, true)
        if matches and #matches > 0 then
          return path
        end
      else
        local stat = vim.uv.fs_stat(path .. "/" .. marker)
        if stat then
          return path
        end
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  return cwd
end

local excluded_dirs = {
  [".git"] = true,
  [".hg"] = true,
  [".svn"] = true,
  ["node_modules"] = true,
  ["target"] = true,
  ["build"] = true,
  ["dist"] = true,
  [".next"] = true,
  [".nuxt"] = true,
  ["venv"] = true,
  [".venv"] = true,
  ["__pycache__"] = true,
  [".pytest_cache"] = true,
  [".turbo"] = true,
  [".cargo"] = true,
  ["out"] = true,
}

local function starts_with_dot(name)
  return name:sub(1, 1) == "."
end

local function scan_dir(root, max_depth, max_files)
  max_depth = max_depth or 3
  max_files = max_files or 500

  local files = {}
  local queue = { { path = root, depth = 0 } }

  while #queue > 0 and #files < max_files do
    local item = table.remove(queue, 1)
    if item.depth > max_depth then
      goto continue
    end

    local handle = vim.uv.fs_scandir(item.path)
    if not handle then
      goto continue
    end

    while true do
      local name, typ = vim.uv.fs_scandir_next(handle)
      if not name or #files >= max_files then
        break
      end

      local full = item.path .. "/" .. name
      if typ == "directory" then
        if not excluded_dirs[name] and not starts_with_dot(name) then
          table.insert(queue, { path = full, depth = item.depth + 1 })
        end
      elseif typ == "file" then
        table.insert(files, name)
      end
    end

    ::continue::
  end

  return files
end

local function glob_to_pattern(glob)
  local pattern = glob
    :gsub("([%.%+%-%^%$%(%)%%])", "%%%1")
    :gsub("%*", ".*")
    :gsub("%?", ".")
  return "^" .. pattern .. "$"
end

local function match_patterns(files, patterns)
  for _, pattern in ipairs(patterns) do
    local lua_pattern = glob_to_pattern(pattern)
    for _, file in ipairs(files) do
      if file:match(lua_pattern) then
        return true
      end
    end
  end
  return false
end

local function detect_files(root)
  local files = scan_dir(root, 3, 500)
  local detected_extras = {}
  local detected_plugins = {}

  for _, lang in ipairs(M.languages) do
    if match_patterns(files, lang.files) then
      for _, extra in ipairs(lang.extras) do
        detected_extras[extra] = true
      end
      if lang.plugins then
        for _, plugin in ipairs(lang.plugins) do
          table.insert(detected_plugins, plugin)
        end
      end
    end
  end

  local extras_list = {}
  for extra in pairs(detected_extras) do
    table.insert(extras_list, extra)
  end
  table.sort(extras_list)

  return extras_list, detected_plugins
end

function M.detect()
  local root = get_project_root()
  local extras, plugins = detect_files(root)
  return extras, plugins, root
end

function M.specs()
  local extras, plugins = M.detect()
  local specs = {}

  for _, extra in ipairs(extras) do
    table.insert(specs, { import = extra })
  end

  for _, plugin in ipairs(plugins) do
    table.insert(specs, plugin)
  end

  return specs
end

function M.info()
  local extras, _, root = M.detect()
  return { root = root, extras = extras, count = #extras }
end

return M
