import requests
from datetime import date


def get_url(year):
    return f"https://nolaborables.com.ar/api/v2/feriados/{year}"


months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
          'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado',
        'Domingo']


def day_of_week(day, month, year):
    return days[date(year, month, day).weekday()]


def _filter_holidays_by_type(holidays, holiday_type):
    if holiday_type is None:
        return holidays
    filtered_holidays = []
    for holiday in holidays:
        if holiday['tipo'] == holiday_type:
            filtered_holidays.append(holiday)
    return filtered_holidays


def is_valid_holiday_type(holiday_type):
    return holiday_type in ["inamovible", "trasladable", "puente",
                            "nolaborable", None]


class NextHoliday:
    def __init__(self):
        self.loading = True
        self.year = date.today().year
        self.holiday = None

    def set_next(self, holidays):
        now = date.today()
        today = {
            'day': now.day,
            'month': now.month
        }

        holiday = next(
            (h for h in holidays if h['mes'] == today['month'] and
             h['dia'] > today['day'] or h['mes'] > today['month']),
            holidays[0]
        )

        self.loading = False
        self.holiday = holiday

    def fetch_holidays(self, holiday_type=None):
        response = requests.get(get_url(self.year)).json()
        if not is_valid_holiday_type(holiday_type):
            raise ValueError(f"Tipo de feriado inválido: '{holiday_type}'.")
        holidays = _filter_holidays_by_type(response, holiday_type)
        if not holidays:
            raise ValueError(f"No existen feriado del tipo: '{holiday_type}'.")
        self.set_next(holidays)

    def render(self):
        if self.loading:
            print("Buscando...")
        else:
            print("Próximo feriado")
            print(self.holiday['motivo'])
            print("Fecha:")
            print(day_of_week(self.holiday['dia'], self.holiday['mes'],
                              self.year))
            print(self.holiday['dia'])
            print(months[self.holiday['mes'] - 1])
            print("Tipo:")
            print(self.holiday['tipo'])


if __name__ == '__main__':
    next_holiday = NextHoliday()
    next_holiday.fetch_holidays("Inamovible")
    next_holiday.render()
