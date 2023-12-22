#!/bin/sh
exec erl -pa ebin deps/*/ebin -sname test_project -s test_project \
-config config/test_project1.config