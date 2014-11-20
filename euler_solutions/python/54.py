from collections import defaultdict

def get_hands():
    f = open("poker.txt")
    text = f.read().replace('\r', '').strip().split("\n")
    f.close()
    for card_list in [l.split(" ") for l in text]:
        a = Hand([Card(e) for e in card_list[:5]])
        b = Hand([Card(e) for e in card_list[5:]])
        yield a, b
        
    





class Hand(object):

    ordering = ['A','1','2','3','4','5','6','7','8',
                '9','T','J','Q','K','A']


    hands = [
        "high",
        "pair",
        "two pair",
        "three",
        "straight",
        "flush",
        "full house",
        "four",
        "straight flush",
        ]

    def __str__(self):
        return "%s, %s" % (str(self.cards), self.get_hand())
        

    def __init__(self, cards):
        self.cards = cards


    def high_winner(self, cards, ocards):
        # Assumes card values are sorted
        c = cmp(max(cards), max(ocards))
        if c != 0:
            return c
        else:
            return self.high_winner(cards[:-1], ocards[:-1])

    def wins(self, opp):
        c = self.compare(opp)
        if c == -1:
            return False
        elif c == 1:
            return True
        else:
            import pdb; pdb.set_trace()
            raise WinsException


    def two_pair_winner(self, card, ocards):

    def pair_winner(self, cards, ocards):
        
        
        

    def compare(self, opp):
        hv = self.get_hand_value()
        ohv = opp.get_hand_value()
        if hv != ohv:
            return cmp(hv, ohv)
        else:
            if hv == 0:
                return self.high_winner(self.card_values(),
                                        opp.card_values())
            elif hv == 1:
                c = cmp(max(self.pairs), max(opp.pairs))
                if c == 0:
                    return cmp(max(self.singles), max(opp.singles))
                else:
                    return c
            else:
                raise CompareException
                
        


    def get_hand(self):
        l = Hand.hands[:]
        l.reverse()
        for e in l:
            method_name = "is_%s" % e.replace(" ", "_")
            method = getattr(self, method_name)
            if method():
                return e

    def get_hand_value(self):
        return self.hands.index(self.get_hand())

    @property
    def face_dict(self):
        d = defaultdict(int)
        for card in self.cards:
            d[card.face] += 1
        return d

    @property
    def singles(self):
        return [k for k,v in self.face_dict.items() if v == 1]


    @property
    def pairs(self):
        return [k for k,v in self.face_dict.items() if v == 2]

    def card_values(self):
        faces = [card.face for card in self.cards]
        o = sorted([self.ordering.index(f) for f in faces])
        return o


    def is_high(self):
        return True

    def is_two_pair(self):
        return sorted(self.face_dict.values()) == [1,2,2] 

    def is_pair(self):
        return max(self.face_dict.values()) >= 2

    def is_three(self):
        return max(self.face_dict.values()) >= 3

    def is_four(self):
        return max(self.face_dict.values()) >= 4            

    def is_full_house(self):
        return set([2,3]) == set(self.face_dict.values())

    def is_straight_flush(self):
        return self.is_straight() and self.is_flush()

    def get_values(self, l, high=True):
        ordering = self.ordering[:]
        if high:
            ordering = ordering[1:]
        return [ordering.index(e.face) for e in l]

    def check_straight_values(self, l):
        ls = sorted(l)
        ls_straight = range(ls[0], ls[0] + len(ls))
        return ls == ls_straight
            

    def is_straight(self):
        if max(self.face_dict.values()) != 1:
            return False
        else:
            sv = self.check_straight_values(self.get_values(self.cards))
            sv2 = self.check_straight_values(self.get_values(self.cards, high=True))
            return sv or sv2

    def is_flush(self):
        suit = self.cards[0].suit
        for card in self.cards:
            if card.suit != suit:
                return False
        return True


class Card(object):


    def __init__(self, txt):
        self.txt = txt
        self.face = txt[0]
        self.suit = txt[1]


    def __repr__(self):
        return self.txt
    





if __name__ == "__main__":
    sum([1 for a,b in list(get_hands()) if a.wins(b)])
