@interface UIViewController (myCategory)

- (void) addNextButton:(NSString *)title;
- (void) killNextButton;
- (void) loadNextView:(id)sender;

- (UITableViewCellStyle) getCellStyle;

- (void) alertWithString:(NSString *)text;
- (void) alertSchema:(NSString *)text;
- (void) alert:(NSInteger)number;
- (void) alert;

- (NSString*)checkIfToAddEndingZero:(NSString*)s;

// Funktioniert nicht, und wenn dann eher für UIView als für UIViewcontroller

// Kategorie für UIViewController, um nicht [self firstResponder] benutzen zu müssen (ist privat)
// was aber viel, viel einfacher wäre.
// - (UIView *)findFirstResponder;
@end