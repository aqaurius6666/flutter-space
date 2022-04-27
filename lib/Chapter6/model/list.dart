class ShoppingLists {
  int? id;
  String name;
  int priority;

  ShoppingLists(this.id, this.name, this.priority);


  Map<String, dynamic> toMap() {
    return {
      'id' : (id != 0) ? id! : null,
      'name' : name,
      'priority' : priority,
    };
  }
}