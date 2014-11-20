from utils import triangles_until

LETTERS = 'abcdefghijklmnopqrstuvwxyz'

VALUES = dict([(v, k) for k, v in enumerate(LETTERS, start=1)])


def get_words():
    s = open("words.txt").read()
    words = s.replace("\"", "").split(",")
    return words




def word_value(word):
    return sum([VALUES[c.lower()] for c in word])

def letter_value(c):
    return VALUES[c]



def count_triangular_words():
    triangles = set(triangles_until(10000))
    triangular_words = [e for e in get_words() if word_value(e) in triangles]
    return len(triangular_words)
    

if __name__ == "__main__":
    print count_triangular_words()
