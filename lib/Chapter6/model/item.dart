class ShoppingItem {
  int? id;
  int listId;
  String name;
  String quantity;
  String note;

  ShoppingItem(this.id, this.listId, this.name, this.quantity, this.note);

  Map<String, dynamic> toMap() {
    return {
      'id' : (id != 0) ? id! : null,
      'listId': listId,
      'name' : name,
      'quantity' : quantity,
      'note' : note,
    };
  }
}