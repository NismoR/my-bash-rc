#!/bin/bash
echo "Updating bashrc files"

## Copy .bashrc file
cp .bashrc ~/.bashrc

## Copy .bash folder
cp .bash ~ -r

## Reload git bash after updating
exec bash