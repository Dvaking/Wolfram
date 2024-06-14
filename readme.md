# Wolfram
## Table of Contents
1. [General Info](#general-info)
2. [Technologies](#technologies)
3. [Installation](#installation)
4. [Overview](#Overview)
## General Info

The goal of this project is to implement [Wolfram’s elementary](https://en.wikipedia.org/wiki/Elementary_cellular_automaton) cellular automaton in the terminal.

    USAGE:
        ./wolfram --rule n --start n --lines n --window --move

    DESCRIPTION:
        --rule n:   rule to use (0 < n < 255)

      - optional:
        --start n:  start line (0 < n)                  | default: 0
        --lines n:  number of lines to print (0 < n)    | default: infinity
        --window n: size of the window (0 < n)          | default: 80
        --move n:   move the window (0 < n)             | default: 0

## Technologies

[![H](https://img.shields.io/badge/Haskell-Dvaking?style=for-the-badge&logo=haskell&logoColor=White&color=purple&link=https%3A%2F%2Fwww.haskell.org%2Fdocumentation%2F)](https://www.haskell.org/documentation/)

## Installation
A little intro about the installation.
```
$ git clone git@github.com:Dvaking/Wolframe.git
$ cd Wolfram
$ make
$ ./wolfram --rule n --start n --lines n --window --move
```
## Overview
```
$ ./wolfram --rule 30 --lines 20
                                        *
                                       ***
                                      **  *
                                     ** ****
                                    **  *   *
                                   ** **** ***
                                  **  *    *  *
                                 ** ****  ******
                                **  *   ***     *
                               ** **** **  *   ***
                              **  *    * **** **  *
                             ** ****  ** *    * ****
                            **  *   ***  **  ** *   *
                           ** **** **  *** ***  ** ***
                          **  *    * ***   *  ***  *  *
                         ** ****  ** *  * *****  *******
                        **  *   ***  **** *    ***      *
                       ** **** **  ***    **  **  *    ***
                      **  *    * ***  *  ** *** ****  **  *
                     ** ****  ** *  ******  *   *   *** ****
```
```
$ ./wolfram --rule 90 --lines 20 --start 100
    *       *                                                       *       *
   * *     * *                                                     * *     * *
  *   *   *   *                                                   *   *   *   *
 * * * * * * * *                                                 * * * * * * * *
*               *                                               *
 *             * *                                             * *             *
  *           *   *                                           *   *           *
 * *         * * * *                                         * * * *         * *
    *       *       *                                       *       *       *
   * *     * *     * *                                     * *     * *     * *
  *   *   *   *   *   *                                   *   *   *   *   *   *
 * * * * * * * * * * * *                                 * * * * * * * * * * * *
                        *                               *
                       * *                             * *
                      *   *                           *   *
                     * * * *                         * * * *
                    *       *                       *       *
                   * *     * *                     * *     * *
                  *   *   *   *                   *   *   *   *
                 * * * * * * * *                 * * * * * * * *
```
