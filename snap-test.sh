#!/bin/bash
set -e

echo -e "Linting...\n"
ng lint

echo -e "Running tests...\n"
ng test --watch false --browsers PhantomJS

echo -e "Running e2e tests...\n"
echo "..."