#!/usr/bin/python3
import re
from collections import Counter

def find_top_word(file_path):

    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read().lower()

    words = re.findall(r"\b\w+\b", content)

    counter = Counter(words)

    word, count = counter.most_common(1)[0]

    print(count, word)

if __name__ == "__main__":
    find_top_word("words.txt")