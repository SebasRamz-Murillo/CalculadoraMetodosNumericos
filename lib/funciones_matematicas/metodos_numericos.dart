class MetodosNumericos {
  /// Resuelve ecuaciones diferenciales usando el método de Euler Mejorado.
  static double resuelveEulerMejorado(double x0, double y0, double h, double xn, Function f) {
    int n = ((xn - x0) / h).round();
    double y = y0;
    for (int i = 0; i < n; i++) {
      double k1 = h * f(x0, y);
      double k2 = h * f(x0 + h, y + k1);
      y += (k1 + k2) / 2;
      x0 += h;
    }
    return y;
  }

  /// Resuelve ecuaciones diferenciales usando el método de Runge-Kutta.
  static double resuelveRungeKutta(double x0, double y0, double h, double xn, Function f) {
    int n = ((xn - x0) / h).round();
    double y = y0;
    for (int i = 0; i < n; i++) {
      double k1 = h * f(x0, y);
      double k2 = h * f(x0 + h / 2, y + k1 / 2);
      double k3 = h * f(x0 + h / 2, y + k2 / 2);
      double k4 = h * f(x0 + h, y + k3);
      y += (k1 + 2 * k2 + 2 * k3 + k4) / 6;
      x0 += h;
    }
    return y;
  }
}
