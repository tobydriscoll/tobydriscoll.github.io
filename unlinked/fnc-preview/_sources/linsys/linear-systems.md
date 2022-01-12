---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.10.3
kernelspec:
  display_name: Julia 1.6.1
  language: julia
  name: julia-fast
---
```{code-cell}
:tags: [remove-cell]
include("../init-notebook.jl")
```

(section-linsys-linear-systems)=
# Linear systems

We now attend to the central problem of this chapter: Given a square, $n\times n$ matrix $\mathbf{A}$ and an $n$-vector $\mathbf{b}$, find an $n$-vector $\mathbf{x}$ such that $\mathbf{A}\mathbf{x}=\mathbf{b}$. Writing out these equations, we obtain

```{math}
\begin{split}
  A_{11}x_1 + A_{12}x_2 + \cdots + A_{1n}x_n &= b_1 \\
  A_{21}x_1 + A_{22}x_2 + \cdots + A_{2n}x_n &= b_2 \\
  \vdots  \\
  A_{n1}x_1 + A_{n2}x_2 + \cdots + A_{nn}x_n &= b_n.
\end{split}
```

```{index} matrix inverse
```

If $\mathbf{A}$ is invertible, then the mathematical expression of the solution is $\mathbf{x}=\mathbf{A}^{-1}\mathbf{b}$, because

```{math}
\begin{split}
  \mathbf{A}^{-1}\mathbf{b} = \mathbf{A}^{-1} (\mathbf{A} \mathbf{x}) = (\mathbf{A}^{-1}\mathbf{A}) \mathbf{x} = \mathbf{I} \mathbf{x}
  = \mathbf{x}.
\end{split}
```

When $\mathbf{A}$ is singular, then $\mathbf{A}\mathbf{x}=\mathbf{b}$ may have no solution or
infinitely many solutions.

(example-singmatrix)=
````{proof:example}
If we define

```{math}
\mathbf{S} =  \begin{bmatrix}
	0 & 1\\0 & 0
\end{bmatrix},
```

then it is easy to check that for any real value of $\alpha$ we have

```{math}
\mathbf{S}
\begin{bmatrix}
	\alpha \\ 1
\end{bmatrix}
=
\begin{bmatrix}
	1 \\ 0
\end{bmatrix}.
```

Hence the linear system $\mathbf{S}\mathbf{x}=\mathbf{b}$ with $\mathbf{b}=\begin{bmatrix} 1\\0\end{bmatrix}$ has infinitely many solutions. For most other choices of $\mathbf{b}$ the system has no solution.
````

## Don't use the inverse

Matrix inverses are indispensable for mathematical discussion and derivations. However, as you may remember from a linear algebra course, they are not trivial to compute from the entries of the original matrix. Julia does have a command `inv` that finds the inverse of a matrix, but it is almost never the best means to solving a problem. In particular, for solving a linear system of equations, finding the inverse is slower than the standard algorithm. 


```{index} Julia; \\
```

As demonstrated in {numref}`Demo %s <demo-interp-vander>`, a linear system of equations can be solved by a `backslash`  (the `\` symbol, not to be confused with the slash `/` used in web addresses).

(demo-systems-backslash)=
```{proof:demo}
```

```{raw} html
<div class='demo'>
```

```{raw} latex
%%start demo%%
```

For a square matrix $A$, the command `A\b` is mathematically equivalent to $A^{-1}b$. 

```{code-cell}
A = [1 0 -1; 2 2 1; -1 -3 0]
```

```{code-cell}
b = [1,2,3]
```

```{code-cell}
x = A\b
```

```{index} residual
```

One way to check the answer is to compute a quantity known as the **residual**. It is (ideally) close to machine precision (relative to the elements in the solution).

```{code-cell}
residual = b - A*x
```

If the matrix $\mathbf{A}$ is singular, you may get an error.

```{code-cell}
A = [0 1; 0 0]
b = [1,-1]
x = A\b
```
::::{panels}
:column: col-7 left-side
:card: border-0 shadow-none
```{raw} latex
\begin{minipage}[t]{0.5\textwidth}
```
The error message here is admittedly cryptic. In this case we can check that the rank of $\mathbf{A}$ is less than its number of columns, indicating singularity.

```{raw} latex
\end{minipage}\hfill
```
---
:column: col-5 right-side
:card: shadow-none comment
```{raw} latex
\begin{minipage}[t]{0.4\textwidth}\begin{mdframed}[default]\small
```
The function `rank` computes the rank of a matrix. However, it is numerically unstable for matrices that are nearly singular, in a sense to be defined in a later section.
```{raw} latex
\end{mdframed}\end{minipage}
```
::::

```{code-cell}
rank(A)
```

A linear system with a singular matrix might have no solution or infinitely many solutions, but in either case, backslash will fail. Moreover, detecting singularity is a lot like checking whether two floating-point numbers are *exactly* equal: because of roundoff, it could be missed. In {numref}`section-linsys-condition-number` we'll find a robust way to fully describe the situation.

```{raw} html
</div>
```

```{raw} latex
%%end demo%%
```

## Triangular systems

```{index} triangular matrix
```

The solution process is especially easy to demonstrate for a system with a **triangular matrix**. For example, consider the lower triangular system

```{math}
  \begin{bmatrix}
    4 & 0 & 0 & 0 \\
    3 & -1 & 0 & 0 \\
    -1 & 0 & 3 & 0 \\
    1 & -1 & -1 & 2
  \end{bmatrix} \mathbf{x} =
  \begin{bmatrix}
    8 \\ 5 \\ 0 \\ 1
  \end{bmatrix}.
```

The first row of this system states simply that $4x_1=8$, which is easily solved as $x_1=8/4=2$. Now, the second row states that $3x_1-x_2=5$. As $x_1$ is already known, it can be replaced to find that $x_2 = -(5-3\cdot 2)=1$. Similarly, the third row gives $x_3=(0+1\cdot 2)/3 = 2/3$, and the last row yields $x_4=(1-1\cdot 2 + 1\cdot 1 + 1\cdot 2/3)/2 = 1/3$. Hence the solution is

```{math}
  \mathbf{x} =
  \begin{bmatrix} 2 \\ 1 \\ 2/3 \\ 1/3
  \end{bmatrix}.
```

```{index} forward substitution
```

The process just described is called **forward substitution**. In the $4\times 4$ lower triangular case of $\mathbf{L}\mathbf{x}=\mathbf{b}$ it leads to the formulas

```{math}
:label: forwardsub
\begin{split}
  x_1 &= \frac{b_1}{L_{11}} \\
  x_2 &= \frac{b_2 - L_{21}x_1}{L_{22}} \\
  x_3 &= \frac{b_3 - L_{31}x_1 - L_{32}x_2}{L_{33}} \\
  x_4 &= \frac{b_4 - L_{41}x_1 - L_{42}x_2 - L_{43}x_3}{L_{44}}.
\end{split}
```

```{index} backward substitution
```

For upper triangular systems $\mathbf{U}\mathbf{x}=\mathbf{b}$ an analogous process of **backward substitution** begins by solving for the last component $x_n=b_n/U_{nn}$ and working backward. For the $4\times 4$ case we have

```{math}
  \begin{bmatrix}
    U_{11} & U_{12} & U_{13} & U_{14} \\
    0 & U_{22} & U_{23} & U_{24} \\
    0 & 0 & U_{33} & U_{34} \\
    0 & 0 & 0 & U_{44}
  \end{bmatrix} \mathbf{x} =
  \begin{bmatrix}
    b_1 \\ b_2 \\ b_3 \\ b_4
  \end{bmatrix}.
```

Solving the system backward, starting with $x_4$ first and then proceeding in descending order, gives

```{math}
\begin{split}
  x_4 &= \frac{b_4}{U_{44}} \\
  x_3 &= \frac{b_3 - U_{34}x_4}{U_{33}} \\
  x_2 &= \frac{b_2 - U_{23}x_3 - U_{24}x_4}{U_{22}} \\
  x_1 &= \frac{b_1 - U_{12}x_2 - U_{13}x_3 - U_{14}x_4}{U_{11}}.
\end{split}
```

It should be clear that forward or backward substitution fails if, and only if, one of the diagonal entries of the system matrix is zero. We have essentially proved the following theorem.


(theorem-triangle-invert)=
```{proof:theorem} Triangular singularity

A triangular matrix is singular if and only if at least one of its diagonal elements is zero.
```

## Implementation

Consider how to implement the sequential process implied by equation {eq}`forwardsub`. It seems clear that we want to loop through the elements of $\mathbf{x}$ in order. Within each iteration of that loop, we have an expression whose length depends on the iteration number. One way we could do this would be with a nested loop:

```julia
for i in 1:4
    s = 0
    for j in 1:i-1
        s += L[i,j]*x[j]
    end
    x[i] = (b[i]-s) / L[i,i]
end
```

```{index} Julia; sum
```

A briefer version of the inner loop over `j` is the expression

``` julia
s = sum( L[i,j]*x[j] for j in 1:i-1 )
```

However, when `i` equals 1, the range `1:i-1` is empty and the sum causes an error. To avoid this we can handle this case before the `i` loop begins, and start that loop at 2. This is the approach taken in {numref}`Function {number} <function-forwardsub>`.

(function-forwardsub)=

````{proof:function} forwardsub
**Forward substitution to solve a lower-triangular linear system**

```{code-block} julia1
:lineno-start: 1
"""
    forwardsub(L,b)

Solve the lower-triangular linear system with matrix `L` and
right-hand side vector `b`.
"""
function forwardsub(L,b)
    n = size(L,1)
    x = zeros(n)
    x[1] = b[1]/L[1,1]
    for i in 2:n
        s = sum( L[i,j]*x[j] for j in 1:i-1 )
        x[i] = ( b[i] - s ) / L[i,i]
    end
    return x
end
```
````

The implementation of backward substitution is much like forward substitution and is given in {numref}`Function {number} <function-backsub>`.

(function-backsub)=
````{proof:function} backsub

**Backward substitution to solve an upper-triangular linear system**

```{code-block} julia1
:lineno-start: 1
"""
    backsub(U,b)

Solve the upper-triangular linear system with matrix `U` and
right-hand side vector `b`.
"""
function backsub(U,b)
    n = size(U,1)
    x = zeros(n)
    x[n] = b[n]/U[n,n]
    for i in n-1:-1:1
        s = sum( U[i,j]*x[j] for j in i+1:n )
        x[i] = ( b[i] - s ) / U[i,i]
    end
    return x
end
```
````

(demo-systems-triangular)=
```{proof:demo}
```

```{raw} html
<div class='demo'>
```

```{raw} latex
%%start demo%%
```

```{index} ! Julia; tril, ! Julia; triu
```

::::{panels}
:column: col-7 left-side
:card: border-0 shadow-none
```{raw} latex
\begin{minipage}[t]{0.5\textwidth}
```
It's easy to get just the lower triangular part of any matrix using the `tril` function.

```{raw} latex
\end{minipage}\hfill
```
---
:column: col-5 right-side
:card: shadow-none comment
```{raw} latex
\begin{minipage}[t]{0.4\textwidth}\begin{mdframed}[default]\small
```
Use `tril` to return a matrix that zeros out everything above the main diagonal. The `triu` function zeros out below the diagonal.
```{raw} latex
\end{mdframed}\end{minipage}
```
::::

```{code-cell}
A = rand(1.:9.,5,5)
L = tril(A)
```

We'll set up and solve a linear system with this matrix.

```{code-cell}
b = ones(5)
x = FNC.forwardsub(L,b)
```

It's not clear how accurate this answer is. However, the residual, while not zero, is comparable to $\macheps$ in size, as we would hope.

```{code-cell}
b - L*x
```

```{index} ! Julia; Pair, Julia; diagm
```

::::{panels}
:column: col-7 left-side
:card: border-0 shadow-none
```{raw} latex
\begin{minipage}[t]{0.5\textwidth}
```
Next we'll engineer a problem to which we know the exact answer. Use `\alpha` <kbd>Tab</kbd> and `\beta` <kbd>Tab</kbd> to get the Greek letters.

```{raw} latex
\end{minipage}\hfill
```
---
:column: col-5 right-side
:card: shadow-none comment
```{raw} latex
\begin{minipage}[t]{0.4\textwidth}\begin{mdframed}[default]\small
```
The notation `0=>ones(5)` creates a `Pair`. In `diagm`, pairs indicate the position of a diagonal and the elements that are to be placed on it.
```{raw} latex
\end{mdframed}\end{minipage}
```
::::

```{code-cell}
α = 0.3;
β = 2.2;
U = diagm( 0=>ones(5), 1=>[-1,-1,-1,-1] )
U[1,[4,5]] = [ α-β, β ]
U
```

```{code-cell}
x_exact = ones(5)
b = [α,0,0,0,1]
```

Now we use backward substitution to solve for `x`, and compare to the exact solution we know already.

```
x = FNC.backsub(U,b)
err = x - x_exact
```

Everything seems OK here. But another example, with a different value for $\beta$, is more troubling.

```{code-cell}
α = 0.3;
β = 1e12;
U = diagm( 0=>ones(5), 1=>[-1,-1,-1,-1] )
U[1,[4,5]] = [ α-β, β ]
b = [α,0,0,0,1]

x = FNC.backsub(U,b)
err = x - x_exact
```

It's not so good to get four digits of accuracy after starting with sixteen! The source of the error is not hard to track down. Solving for $x_1$ performs $(\alpha-\beta)+\beta$ in the first row. Since $|\alpha|$ is so much smaller than $|\beta|$, this a recipe for losing digits to subtractive cancellation.

```{raw} html
</div>
```

```{raw} latex
%%end demo%%
```

The example in {numref}`Demo %s <demo-systems-triangular>` is our first clue that linear system problems may have large condition numbers, making inaccurate solutions inevitable in floating-point arithmetic. We will learn how to spot such problems in {numref}`section-linsys-condition-number`. Before reaching that point, however, we need to discuss how to solve general linear systems, not just triangular ones.

## Exercises

1. ✍ Find a vector $\mathbf{b}$ such that the system $\begin{bmatrix} 0&1\\0&0 \end{bmatrix} \mathbf{x}=\mathbf{b}$ has no solution.

    (problem-linear-systems-triangular)=
2. ✍ Solve the following triangular systems by hand.

    **(a)** $\displaystyle \begin{aligned}
      -2x_1  &= -4 \\
        x_1  - x_2        &= 2 \\
       3x_1 + 2x_2  + x_3 &= 1
      \end{aligned} \quad$
    **(b)** $\displaystyle \begin{bmatrix}
        4 & 0 & 0 & 0 \\
        1 & -2 & 0 & 0 \\
        -1 & 4 & 4 & 0 \\
        2 & -5 & 5 & 1
      \end{bmatrix} \mathbf{x} = \begin{bmatrix}
        -4 \\ 1 \\ -3 \\ 5
      \end{bmatrix}\quad$
    **(c)** $\displaystyle \begin{aligned}
       3x_1 +  2x_2  +  x_3      &= 1 \\
               x_2   -  x_3      &= 2 \\
                        2 x_3    &= -4
      \end{aligned}$

3. ⌨ Use {numref}`Function {number} <function-forwardsub>` or {numref}`Function {number} <function-backsub>` to solve each system from the preceding exercise. Verify that the solution is correct by computing $\mathbf{L}\mathbf{x}$ and subtracting $\mathbf{b}$.

4. ⌨  Use {numref}`Function {number} <function-backsub>` to solve the following systems.  Verify that the solution is correct by computing $\mathbf{U}\mathbf{x}$ and subtracting $\mathbf{b}$.

    **(a)** $\;\begin{bmatrix}
      3 & 1 & 0  \\
      0 & -1 & -2  \\
      0 & 0 & 3  \\
    \end{bmatrix} \mathbf{x} = \begin{bmatrix}
      1 \\ 1 \\ 6
    \end{bmatrix}\qquad$
    **(b)** $\;\begin{bmatrix}
      3 & 1 & 0 & 6 \\
      0 & -1 & -2 & 7 \\
      0 & 0 & 3 & 4 \\
      0 & 0 & 0 & 5
    \end{bmatrix} \mathbf{x} = \begin{bmatrix}
      4 \\ 1 \\ 1 \\ 5
    \end{bmatrix}$

    (problem-linear-systems-lumpstring)=
5. Suppose a string is stretched with tension $\tau$ horizontally between two anchors at $x=0$ and $x=1$. At each of the $n-1$ equally spaced positions $x_k=k/n$, $k=1,\ldots,n-1$, we attach a little mass $m_i$ and allow the string to come to equilibrium. This causes vertical displacement of the string. Let $q_k$ be the amount of displacement at $x_k$. If the displacements are not too large, then an approximate force balance equation is
  
    ```{math} 
    n \tau (q_k - q_{k-1}) + n\tau (q_k - q_{k+1}) =
    m_k g, \qquad k=1,\ldots,n-1,
    ```

    where $g=-9.8$ m/s$^2$ is the acceleration due to gravity, and we define $q_0=0$ and $q_n=0$ due to the anchors. This defines a linear system for $q_1,\ldots,q_{n-1}$.

    **(a)** ✍ Show that the force balance equations can be written as a linear system $\mathbf{A}\mathbf{q}=\mathbf{f}$, where $\mathbf{q}$ is a vector of the unknown displacements and $\mathbf{A}$ is a tridiagonal matrix, i.e., $A_{ij}=0$ if $|i-j|>1$) of size $(n-1)\times(n-1)$.

    **(b)** ⌨  Let $\tau=10$ N, and $m_k=(1/10n)$ kg for every $k$. Using backslash, find the displacements when $n=8$ and $n=40$, and superimpose plots of $\mathbf{q}$ over $0\le x \le 1$ for the two cases. (Be sure to include the zero values at $x=0$ and $x=1$ in your plots.)

    **(c)** ⌨  Repeat (b) for the case $m_k = (k/5n^2)$ kg.

    (problem-systemsinverse)=
6. ⌨  If $\mathbf{B}\in\mathbb{R}^{n \times p}$, has columns $\mathbf{b}_1,\ldots,\mathbf{b}_p$, then we can pose $p$ linear systems at once by writing $\mathbf{A} \mathbf{X} = \mathbf{B}$, where $\mathbf{X}$ is $n\times p$. Specifically, this equation implies $\mathbf{A} \mathbf{x}_j = \mathbf{b}_j$ for $j=1,\ldots,p$.

    **(a)** Modify {numref}`Function {number} <function-forwardsub>` and {numref}`Function {number} <function-backsub>` so that they solve the case where the second input is $n\times p$ for $p\ge 1$.

    **(b)** If $\mathbf{A} \mathbf{X}=\mathbf{I}$, then $\mathbf{X}=\mathbf{A}^{-1}$. Use this fact to write a function `ltinverse` that uses your modified **forwardsub** to compute the inverse of a lower triangular matrix. Test your function on at least two nontrivial matrices. (We remind you here that this is just an exercise; matrix inverses are rarely a good idea in numerical practice!)

    (problem-ls-triangillcond)=
7. ⌨ {numref}`Demo %s <demo-systems-triangular>` showed solutions of $\mathbf{A}\mathbf{x}=\mathbf{b}$, where
  
    ```{math}
    \mathbf{A} = \begin{bmatrix} 1 & -1 & 0 & \alpha-\beta & \beta \\ 0 & 1 & -1 &
      0 & 0 \\ 0 & 0 & 1 & -1 & 0 \\ 0 & 0 & 0 & 1 & -1  \\ 0 & 0 & 0 & 0 & 1
    \end{bmatrix}, \quad
    \mathbf{b} = \begin{bmatrix} \alpha \\ 0 \\ 0 \\ 0 \\ 1 \end{bmatrix}.
    ```

    Use {numref}`Function {number} <function-backsub>` to solve with $\alpha=0.1$ and $\beta=10,100,10^3,\ldots,10^{12}$, tabulating the values of $\beta$ and $|x_1-1|$. (This kind of behavior is explained in {numref}`section-linsys-condition-number`.)


