# Advanced Building Blocks

A couple programming problems in Ruby for The Odin Project's [Projects: Advanced Building Blocks](http://www.theodinproject.com/ruby-programming/advanced-building-blocks).


### Bubble Sort

May be run with `ruby bubble_sort.rb`

* `#bubble_sort` sorts an array using the bubble sort method.
* `#bubble_sort_by` sorts an array using the bubble sort method, but expects a block which it uses to compare two elements of the array. The block's return should be similar to the spaceship operator (`<=>`).


### Enumerable methods

You may use the new methods after requiring the file with `require './enumerable_methods'`.

* Extend Ruby's Enumerable module to include `#my_each`, `#my_each_with_index`, `#my_select`, `#my_all?`, `#my_any?`, `#my_none?`, `#my_count`, `#my_map`, and `#my_inject`.  Each of these methods perform similarly to the corresponding Enumerable method (e.g `#my_each` is similar to `#each`).
