abstract class Repository<T> {
  Repository();

  T salvar(T t);

  T buscar(int id);

  List<T> lista();
}
