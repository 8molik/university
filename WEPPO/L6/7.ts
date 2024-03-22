// unshift
type Unshift<T extends any[], U> = [U, ...T];

// myreadonly
type MyReadonly<T> = {
    readonly [Key in keyof T] : T[Key]
}

// if
type If<C extends boolean, T extends any, F extends any> = C extends true ? T : F;

// concat
type Concat<T extends readonly any[], U extends readonly any[]> = [...T, ...U];

// mypick
type MyPick<T, K extends keyof T> = {
    [SpecificKey in K] : T[SpecificKey];
};

// push
type Push<T extends any[], U> = [...T, U]

// parameters
type MyParameters<T extends (...args: any[]) => any>  = T extends (...args: infer R) => any ? R : any 

type Length<T extends any[]> = T['length']

type First<T extends any[]> = T extends [infer P, ...any[]] ? P : never