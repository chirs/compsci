
from collections import defaultdict

dice_list = [4, 2, 1]



def winning_percentage(wins, losses):
    return (1.0 * wins) / (wins + losses)


def adj_win(wins, losses, ties=0):
    return 1.0 * (wins + .5 * ties) /  (wins + losses + ties)

def dice_values(sides):
    return range(1, sides+1)


def expected_results(dice_list):
    d = defaultdict(int)
    if len(dice_list) == 1:
        die = dice_list[0]
        for e in dice_values(die):
            d[e] = 1
    else:
        die = dice_list[0]
        old_d = expected_results(dice_list[1:])
        for e in dice_values(die):
            for key, value in old_d.items():
                nk = key + e
                d[nk] += value
    return d


def compare_results(d, o):
    wins = ties = losses = 0
    for score, count in d.items():
        for o_score, o_count in o.items():
            c = count * o_count
            if score > o_score:
                wins += c
            elif score == o_score:
                ties += c
            else:
                losses += c
    return (wins, ties, losses)


if __name__ == "__main__":
    d = expected_results([4] * 9)
    o = expected_results([6] * 6)
    print d
    print o
    wins, ties, losses = compare_results(d, o)
    print winning_percentage(wins, losses)
    print adj_win(wins, losses, ties)
