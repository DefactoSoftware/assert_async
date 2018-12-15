[![Hex.pm](https://img.shields.io/hexpm/v/assert_async.svg)](https://hex.pm/packages/assert_async)

# AssertAsync

Assert tests with retries for async testing.

## Installation

Can be installed via git:

```elixir
def deps do
  [
    {:assert_async, git: "https://github.com/defactosoftware/assert_async", only: [:test]}
  ]
end
```

usage in test

```ex
defmodule YourApp.SomeModuleTest do
  use ExUnit.Case

  import AssertAsync

  test "testing something async" do
    some_async_insert()

    assert_eventually(Ecto.Repo.exists?(InsertedThing))
  end
end
```

