export class Forth {
  #stack = [];
  #defs = {};

  static OPS = {
    '+': {min_stack: 2, func: (f) => f.#stack.push(f.pop() + f.pop())},
    '-': {min_stack: 2, func: (f) => f.#stack.push(f.pop(2) - f.pop())},
    '*': {min_stack: 2, func: (f) => f.#stack.push(f.pop() * f.pop())},
    '/': {min_stack: 2, func: (f) => f.#stack.push(div(f.pop(2), f.pop()))},
    'dup': {min_stack: 1, func: (f) => f.#stack.push(f.peek(1))},
    'drop': {min_stack: 1, func: (f) => f.pop()},
    'swap': {min_stack: 2, func: (f) => f.#stack.push.apply(f.#stack, [f.pop(), f.pop()])},
    'over': {min_stack: 2, func: (f) => f.#stack.push(f.peek(2))},
  };

  /**
   * @param {string} commands
   * @throws {Error}
   */
  evaluate(commands) {
    let words = commands.split(' ').map((word) => word.toLowerCase()), iNext, word;
    for (let i = 0; i < words.length;) {
      if ((word = words[i++]) == ':') {
        throwIf((iNext = words.indexOf(';', i)) < (i + 1) || /^-?\d+$/.test(words[i]), 'Invalid definition');
        this.#defs[words[i]] = words.slice(i + 1, iNext).flatMap((w) => this.#defs[w] ?? w);
        i = iNext + 1;
      } else if (word in this.#defs) {
        this.evaluate(this.#defs[word].join(' '));
      } else if (word in Forth.OPS) {
        throwIf(this.#stack.length < 1, 'Stack empty');
        throwIf(this.#stack.length < 2 && Forth.OPS[word].min_stack == 2, 'Only one value on the stack')
        Forth.OPS[word].func(this);
      } else {
        throwIf(!/^-?\d+$/.test(word), 'Unknown command', () => this.#stack.push(Number(word)));
      }
    }
  }

  /**
   * @returns {number[]}
   */
  get stack() { return this.#stack; }

  /**
   * @param {number} n
   * @returns {number}
   * @throws {Error}
   */
  pop = (n = 1) => this.#stack.splice(-n, 1)[0];

  /**
   * @param {number} n
   * @returns {number}
   */
  peek = (n) => this.#stack[this.#stack.length - n];
}

/**
 * @param {boolean} cond
 * @param {string} msg
 * @param {function|null} func
 * @returns {number|undefined}
 * @throws {Error}
 */
const throwIf = (cond, msg, func = null) => { if (cond) { throw new Error(msg); } else { return func?.(); } }

/**
 * @param {number} a
 * @param {number} b
 * @returns {number}
 * @throws Error
 */
const div = (a, b) => throwIf(b == 0, 'Division by zero', () => Math.floor(a / b));
