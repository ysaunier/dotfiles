from datetime import datetime, timedelta


class VestingSchedule(timedelta):
    """
    Base class for vesting schedules.
    """

    @property
    def increment(self) -> float:
        return self.increment


class OneYear(VestingSchedule):
    """
    One year cliff, after which 25% of your Stock Options vest.
    """
    increment = 0.25

    def __new__(cls) -> VestingSchedule:
        return super().__new__(cls, weeks=52)


class Monthly(VestingSchedule):
    """
    Monthly vesting schedule for the 4 years after the cliff, where 1/48 of the
    Stock Options are vested each month.
    """
    increment = 1 / 48

    def __new__(cls) -> VestingSchedule:
        return super().__new__(cls, weeks=4.33)


class Grant:
    """
    A Stock Options grant, with a given strike price, quantity and vesting schedule.
    """

    def __init__(
            self,
            cliff: VestingSchedule,
            vesting: VestingSchedule,
            strike_price: float,
            quantity: int,
            grant_date: datetime
    ) -> None:
        self.cliff = cliff
        self.vesting = vesting
        self.strike_price = strike_price
        self.quantity = quantity
        self.grant_date = grant_date


def calculate_vesting(grant: Grant, date: datetime) -> float:
    """
    Calculate the number of Stock Options vested a given date.
    """
    delta = date - grant.grant_date
    options_vested = 0
    if delta > grant.cliff:
        options_vested += grant.cliff.increment * grant.quantity
        delta -= grant.cliff
    months = delta.days // (7 * 4.3333)
    for _ in range(int(months)):
        options_vested += grant.vesting.increment * grant.quantity
    return options_vested if options_vested <= grant.quantity else grant.quantity


def calculate_buying_price(grant: Grant, date: datetime) -> float:
    """
    Calculate how much it would cost you to exercise your vested options.
    """
    options_vested = calculate_vesting(grant=grant, date=date)

    return grant.strike_price * options_vested


def calculate_market_value(grant: Grant, date: datetime, unit_price: float) -> float:
    """
    Calculate the current market value of your vested options.
    """
    options_vested = calculate_vesting(grant=grant, date=date)
    return unit_price * options_vested


if __name__ == "__main__":

    grants = [
        # A list of stock option grants your received, ADJUST WITH YOURS
        Grant(cliff=OneYear(), vesting=Monthly(), strike_price=0.50, quantity=25_000, grant_date=datetime(2020, 1, 1)),
    ]
    # What you think the current fair market value is for your stock options,
    # the number is a mystery but you can play with it to check different scenarios.
    CURRENT_FAIR_MARKET_VALUE = 1.25
    now = datetime.now()
    options_vested = 0
    exercise_price = 0
    market_value = 0
    for grant in grants:
        options_vested += calculate_vesting(grant=grant, date=now)
        exercise_price += calculate_buying_price(grant=grant, date=now)
        market_value += calculate_market_value(grant=grant, date=now, unit_price=CURRENT_FAIR_MARKET_VALUE)
    print(f"As of {now:%Y-%m-%d}...\n")
    print(f"Options vested: {options_vested:.2f}")
    print(f"Exercise price: {exercise_price:.2f}$")
    print(f"Market value: {market_value:.2f}$")
    print(f"\nGain: {market_value - exercise_price:.2f}$")
