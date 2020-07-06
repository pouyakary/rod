
# Rod
A simple language to convert a switch case into ternary operator in C style. Works with everything!

## Usage

Install using:

```
% make install
```

Put your source in a file and do:

```
% rod myfile.rod
```

## Language

```
prop("Test") ::: "X"
---
== 1 ==> "one"
== 2 ==> "two"
== 3 ==> "tree"
== 4 ==> "four"
```

Compiles to:

```
(prop("Test") == 1) ? ("one") : ((prop("Test") == 2) ? ("two") : ((prop("Test") == 3) ? ("tree") : ((prop("Test") == 4) ? ("four") : ("X"))))
```

Before the `---` is the header. On the left side of the `:::` is the _switch on_ and on the right side of it is the default value. Then after the `---` are rules. On the left of the `==>` is the condition (concating switch on on the `?`) and then the value