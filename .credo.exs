%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "test/"],
        excluded: ["test/support/*_case.ex"]
      },
      checks: [
        {Credo.Check.Readability.ModuleDoc, false}
      ]
    },
    %{
      name: "support",
      files: %{
        included: ["test/support/*_case.ex"],
        excluded: []
      },
      checks: [
        {Credo.Check.Design.AliasUsage, false}
      ]
    }
  ]
}
