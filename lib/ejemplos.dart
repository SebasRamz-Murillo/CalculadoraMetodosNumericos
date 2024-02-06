/*         Text('Expression: $_expression'),
        Text('Result: $_result'),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter your expression',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Math.tex(
              r'\frac{1}{\sqrt{2}}\int_{-\infty}^\infty e^{-x^2} dx',
              textStyle: TextStyle(fontSize: 24),
            ),

            /* ElevatedButton(
              onPressed: _calculateResult,
              child: const Text('Calcular'),
            ), */
            ElevatedButton(
              onPressed: _clear,
              child: const Text('Clear'),
            ),
          ],
        ),
 */