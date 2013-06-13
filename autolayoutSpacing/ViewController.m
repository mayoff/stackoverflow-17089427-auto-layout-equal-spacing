
    #import "ViewController.h"

    @interface ViewController ()

    @end

    @implementation ViewController {
        NSMutableArray *textFields;
        UIView *topSpacer;
    }

    - (void)viewDidLoad {
        [super viewDidLoad];
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addTextFields];
        [self addSpacers];
    }

    - (void)addTextFields {
        textFields = [NSMutableArray array];
        for (int i = 0; i < 12; ++i) {
            [self addTextField];
        }
    }

    - (void)addTextField {
        UITextField *field = [[UITextField alloc] init];
        field.backgroundColor = [UIColor colorWithHue:0.8 saturation:0.1 brightness:0.9 alpha:1];
        field.translatesAutoresizingMaskIntoConstraints = NO;
        field.text = [field description];
        [self.view addSubview:field];
        [field setContentCompressionResistancePriority:UILayoutPriorityRequired
            forAxis:UILayoutConstraintAxisVertical];
        [field setContentHuggingPriority:UILayoutPriorityRequired
            forAxis:UILayoutConstraintAxisVertical];
        [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"|-[field]-|" options:0 metrics:nil
            views:NSDictionaryOfVariableBindings(field)]];
        [textFields addObject:field];
    }

    - (void)addSpacers {
        [self addTopSpacer];
        for (int i = 1, count = textFields.count; i < count; ++i) {
            [self addSpacerFromBottomOfView:textFields[i - 1]
                toTopOfView:textFields[i]];
        }
        [self addBottomSpacer];
    }

    - (void)addTopSpacer {
        UIView *spacer = [self newSpacer];
        UITextField *field = textFields[0];
        [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|[spacer][field]" options:0 metrics:nil
            views:NSDictionaryOfVariableBindings(spacer, field)]];
        topSpacer = spacer;
    }

    - (UIView *)newSpacer {
        UIView *spacer = [[UIView alloc] init];
        spacer.hidden = YES; // Views participate in layout even when hidden.
        spacer.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:spacer];
        [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"|[spacer]|" options:0 metrics:nil
            views:NSDictionaryOfVariableBindings(spacer)]];
        return spacer;
    }

    - (void)addSpacerFromBottomOfView:(UIView *)overView toTopOfView:(UIView *)underView {
        UIView *spacer = [self newSpacer];
        [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:[overView][spacer(==topSpacer)][underView]" options:0 metrics:nil
            views:NSDictionaryOfVariableBindings(spacer, overView, underView, topSpacer)]];
    }

    - (void)addBottomSpacer {
        UIView *spacer = [self newSpacer];
        UITextField *field = textFields.lastObject;
        [self.view addConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:[field][spacer(==topSpacer)]|" options:0 metrics:nil
            views:NSDictionaryOfVariableBindings(spacer, field, topSpacer)]];
    }

    @end
