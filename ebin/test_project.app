{application, 'test_project', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['test_module','test_project_app','test_project_sup']},
	{registered, [test_project_sup]},
	{applications, [kernel,stdlib]},
	{optional_applications, []},
	{mod, {test_project_app, []}},
	{env, []}
]}.