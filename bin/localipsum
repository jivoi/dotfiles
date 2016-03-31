#!/usr/bin/env python3

import os
import random
import sys
import argparse


def main():
    parser = argparse.ArgumentParser(description='Localispum is a simple \
            program providing sample text generating from your own \
            dictionaries')
    parser.add_argument('integer', type=positive_integer,
                   help='The number of [paragraphes|sentences|words] you want.')
    parser.add_argument('--paragraphs', '-p', action='store_true')
    parser.add_argument('--sentences', '-s', action='store_true')
    parser.add_argument('--words', '-w', action='store_true')
    parser.add_argument('--lorem', '-l', action='store_true', help='If set, \
    start with "Lorem ipsum dolor sit amet,"')

    args = parser.parse_args()

    if not (args.paragraphs or args.sentences or args.words):
        print('One of the following argument is required:\n\
                --paragraphs\n\
                --sentences\n\
                --words ')
        sys.exit(0)

    # let's build a word list
    words = []

    # let's see if there is a locations file
    try:
        locations = open('locations', 'r')
    except FileNotFoundError:
        print("No location file found, you need one !")
        sys.exit(0)

    # open all files contain in locations
    for location in locations:
        if location[0] != '#':
            if os.path.exists(location.strip()):
                try:
                    for filename in os.listdir(location.strip()):
                        f = open(location.strip()+filename, 'r')
                        try:
                            for line in f:
                                words.append(line.strip())
                        except UnicodeDecodeError:
                            print('No reconize file: {}'.format(filename),
                                  file=sys.stderr)
                except FileNotFoundError:
                    pass

    # did we find a dictionary ?
    if len(words) == 0:
        print("No dictionary found, you may want to add one in the locations file")
        sys.exit(0)

    # TODO sort all the words ? (if not to slow)
    # We do not want to sort the list but to remove duplicates
    # words.sort() does not delete duplicate

    str = ""
    if args.lorem:
        # let's start with the well know Latin locution
        str = "Lorem ipsum dolor sit amet, "

    n = args.integer

    # print random
    if args.paragraphs:
        str += printParagraphs(words, n)
    if args.sentences:
        str += printSentences(words, n)
    if args.words:
        if args.lorem:
            n -=5
        str += printWords(words, n)

    print(str)


def positive_integer(value):
    value = int(value)
    if value <= 0:
        raise TypeError('The integer must be positive')
    return value


def printWords(words, n):
    # if n > ? : let's add some comma
    if n < 1:
        return ""
    comma = False
    if n > 7:
        comma = True
    str = ""
    for i in range(0, n-1):
        if comma and i > random.randint(0, n):
            str += words[random.randint(0, len(words)-1)]+", "
            comma = False
        else:
            str += words[random.randint(0, len(words)-1)]+" "
    return (str + words[random.randint(0, len(words)-1)])


def printSentences(words, n):
    str = ""
    for i in range(0, n-1):
        str += (printWords(words, random.randint(10, 25))+". ").capitalize()
    return str + (printWords(words, random.randint(10, 25))+".").capitalize()


def printParagraphs(words, n):
    str = ""
    for i in range(0, n-1):
        str += printSentences(words, random.randint(4, 8))+"\n\n"
    return str + printSentences(words, random.randint(4, 8))


if __name__ == "__main__":
    main()
