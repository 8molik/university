import { create, all } from 'mathjs';

const math = create(all);

export function handleButtonClick(value: string, expression: string): string {
  if (expression === 'Error' && (value === 'DEL' || !isNaN(Number(value)))) {
    return value === 'DEL' ? '' : value;
  }

  if (value === 'CE') {
    return '';
  } else if (value === 'DEL') {
    return expression.slice(0, -1);
  } else if (value === '=') {
    try {
      return math.evaluate(expression).toString();
    } catch {
      return 'Error';
    }
  } else {
    return expression + value;
  }
}