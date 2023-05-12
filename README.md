# RemoveUnused

Remove unused aliases and imports automatically.

## Installation


```elixir
def deps do
  [
    {:remove_unused, "~> 0.1.0"}
  ]
end
```

**Optional**

If you want `mix format` to run this library automatically, then use this.

```elixir
 defp aliases do
    [
      format: ["remove_unused", "format"]
    ]
  end
```

The original intent was to make a `mix format` plugin, but it needs to fetch the unused files list from `mix compile` and since it takes time it doesn't make sense to run it for every file, which is how `format` plugins work.

## Usage

Just run `mix remove_unused` in the console.

## Caveat

This plugin would currently remove lines like `alias App.{One,Two,Three}` even of only `One` is unused. This is because I personally don't use that format and I haven't decided if this should be an official package or not. I'm waiting feedback from you! In the forum.
