
State = TypeVar('State') # could be anything
a = TypeVar('a')
b = TypeVar('b')


TST = Callable[[State], (a, State)]

class ST(Generic[a]):
    def stf(s: State) -> (a, State):
        ...


def fmap(g: Callable[[a], b], st: ST[a]) -> ST[b]:
    def new_stf(s: State) -> (b, State):
        x, s_prime = st.stf(st, s)
        return (g(x), s_prime)
    return ST(stf=new_stf)


# example ST
class IncrementAndReport(ST):
    def stf(s: int) -> (int, int):
        return s, s + 1

def pretty_reporter(count: int) -> str:
    return f'The state was {count}'

# And then the point is what you get from
IncrementAndPrettyReport = fmap(pretty_reporter, IncrementAndReport)

