conda doesn't have a "replaces" concept for packages, which makes it challenging to have pkgA be mutually exclusive to pkgB.
To solve this we have to have a common "lock" package which each exclusive package depends upon.

The results...


It is possible to install a single, chosen package:


```
$ conda create -yq -n test-pkg-a pkg-a

The following NEW packages will be INSTALLED:

    pkg-a:     1-0     local
    xclsv-pkg: 1-pkg_a local
```


It is possible to switch to the other package by removing it first:

```
$ conda create -yq -n test-a-then-b pkg-a

The following NEW packages will be INSTALLED:

    pkg-a:     1-0     local
    xclsv-pkg: 1-pkg_a local


$ conda remove -yq -n test-a-then-b pkg-a

The following packages will be REMOVED:

    pkg-a: 1-0 local


$ conda install -yq -n test-a-then-b pkg-b

The following NEW packages will be INSTALLED:

    pkg-b:     1-0     local

The following packages will be UPDATED:

    xclsv-pkg: 1-pkg_a local --> 1-pkg_b local

```


However, it isn't possible to install both at the same time (without a --force):

```
+ conda create -yq -n test-both pkg-a pkg-b

UnsatisfiableError: The following specifications were found to be in conflict:
  - pkg-a
  - pkg-b -> xclsv-pkg * pkg_b
```


