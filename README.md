# code_reminder_examples
Examples for how to use the code_reminder zig package.
`code_reminder`: https://github.com/swan-www/code_reminder

## How to run
Examples made against `Zig 0.12.0-dev.3522+b88ae8dbd` (2024-04-03).

- Run `zig build` in either of the directories and they should build without error or extra output.

- Under `/code_reminder_example_comptime` run `zig build -DenableCodeRemindersByName=Foo`, the build should fail with the following somewhere in the output:
```
:88:17: error: found compile log statement
                @compileLog(
                ^~~~~~~~~~~

Compile Log Output:
@as(*const [113:0]u8, "CodeReminder: reminder{Foo} with proposal_id {12345} triggered at main.zig:15:41 -- \"fooFunc has been deprecated\"")
```

- Under `code_reminder_example_buildtime/` run `zig build "-DenableCodeRemindersByName=MyTodoBuildUtil,Foo,Bar"`, the build should output the following somewhere in the output:
```
warning: CodeReminder:{MyTodoBuildUtil} with proposal_id {N/A} triggered at D:\devspace\code_reminder_examples\code_reminder_example_buildtime\build.zig:23:38 -- "Replace this function with 'newBuildUtilFunctionToUse'"
warning: CodeReminder:{Foo} with proposal_id {12345} triggered at D:\devspace\code_reminder_examples\code_reminder_example_buildtime\build.zig:35:26 -- "foo has been deprecated"
```

## Additional info

Note that you can also run both of these examples by specifying the `proposal_id` of the reminder, with the command `zig build -DenableCodeRemindersByProposalNumber=12345`. This might be useful if you associate the reminder with a github issue, or any external task tracking. The proposal number can be assigned optionally when you define a CodeReminder.

Both of these options also support wildcards:
`zig build -DenableCodeRemindersByName=*`
`zig build -DenableCodeRemindersByProposalNumber=*`