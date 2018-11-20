#!/bin/bash

#### JavaRL Examples/Tutorial

### Running JavaRL

# The JavaRL system is packaged inside a directory javarl/
# Due to the way java packages work, the JavaRL class files
# must stay inside the javarl/ directory. Let's suppose the
# location of the javarl/ is /home/user/javarl (the path
# on your system will be different). Then we should do the
# following to execute javaRL:

## 1) Configure JavaRL

# JavaRL's configuration is done through a simple
# configuration file located at:
#
# javarl/JavaRLConfiguration.properties
#
# The file contains three lines:
#
# MaudePath: ...
# SpecPath:  ...
# MCPath:    ...
#
# The MaudePath should be set to the location of a working
# Maude binary on your system. The SpecPath should be set
# to the location of JavaRL Maude semantics (if you received
# this file as part of the JavaRL examples/tutorial archive,
# the semantics is located at:
#
# javarl/java-rl-spec
#
# Finally, the MCPath should point to the model-checker.maude
# file, which is included in the standard Maude distribution.
# Thus, it will probably be in the same folder where your
# Maude binary is located.

## 2) Run JavaRL

# cd /home/user
# java javarl.JavaRL <args>
#
# NOTE: The directory change step is unnecessary if the
# current directory is already the parent of javarl/
#
# Assuming you received this file as part of the JavaRL
# examples/tutorial archive, to run this examples file,
# just execute demo.sh in the same directory as this script
# after setting the configuration properties correctly.

### JavaRL Syntax

# JavaRL uses separate file formats for system specification
# and for property specification.

# The system specification file format is just the standard
# Java code format (using the .java extension).

# The property specification file format is custom for this
# tool. A BNF syntax is provided below:

# Property    ::= <Atom>* <Formula>
# Atom        ::= "atom" <name> ":" <className> {"." | "@"} <BooleanExp> {“/\" <BooleanExp>}* 
# BooleanExp  ::= <field> {">" | ">=" | "<" | "<=" | "=="} <integer> 
# Formula     ::= "formula" ":" <LTL Formula>
# LTL Formula ::= <LTL UnaryOp>(<LTL Formula>) | <LTL Formula> <LTL BinaryOp> <LTL Formula>

# The syntactic category <name> can be any alphabetic word
# without whitespace. The syntactic categories <className>
# and <field> both come from the .java file which you are
# currently checking. The syntactic categories "LTL UnaryOp"
# and "LTL BinaryOp" come from the LTL Maude module located
# in the model-checker.maude file included with your Maude
# distribution. The LTL syntax below was taken from the
# model-checker.maude file included with the Maude 2.6 
# distribution (written using Maude mixfix notation):

## Unary LTL Operators

#   op ~_ : Formula -> Formula 
#   op O_ : Formula -> Formula 
#   op <>_ : Formula -> Formula 
#   op []_ : Formula -> Formula
   
## Binary LTL Operators

#   op _/\_ : Formula Formula -> Formula 
#   op _\/_ : Formula Formula -> Formula 
#   op _U_ : Formula Formula -> Formula 
#   op _R_ : Formula Formula -> Formula 
#   op _->_ : Formula Formula -> Formula 
#   op _<->_ : Formula Formula -> Formula 
#   op _W_ : Formula Formula -> Formula 
#   op _|->_ : Formula Formula -> Formula 
#   op _=>_ : Formula Formula -> Formula 
#   op _<=>_ : Formula Formula -> Formula 

## At-Sign vs Dot Operator

# The difference between "@" and "." is that field names
# occuring in an expression following "@" are dynamic
# members of the class being referenced, whereas fields
# following a "." are static class members. There is no
# way currently to reference variables local to a method
# in the property specification.

## Final Word on Parsing

# The JavaRL tool will dump whatever you write after the
# token "formula:" into the Maude file it passes to the
# backend. This means if you mistype an LTL formula,
# the Maude backend will fail and JavaRL will report
# a bogus counterexample. Thus, check your formulas
# carefully.

# Why isn't this bug fixed, you ask? Well, I don't
# where the source code is, and nobody else seems to
# either.

## JavaRL Examples

# The examples below can be run by just executing
# this file. Feel free to comment out the original
# command and change it to see what happens.

## run HelloWorld.java
#java javarl.JavaRL -cls HelloWorld.java
#
## run Sum.java
#java javarl.JavaRL -cls Sum.java
#
## Check deadlocks
#java javarl.JavaRL -cls Sum.java -s deadlock
#
## model check the Sum.java
#java javarl.JavaRL -cls Sum.java -mc Sum.prop
#
## generate maude code
#java javarl.JavaRL -cls Sum.java -mc Sum.prop -maudecode
#
## counterexample for another property
#java javarl.JavaRL -cls Sum.java -mc Sum2.prop > counterex
#
# model checking the reader-writer example
java javarl.JavaRL -cls rw.java -mc rw.prop
