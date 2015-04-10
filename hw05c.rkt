;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw05c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Chase Irby
; hw05a
; http://www.radford.edu/~itec380/2014fall-ibarland/Homeworks/hw05/hw05.html
(require 2htdp/image)
(require 2htdp/universe)
;
;   a ball is:
;   (make-ball [real?] [real?])
;
(define-struct ball (x y dx dy))
;
;  x is the distance from the left edge of screen, in pixels.
;  y is the distance from the top  edge of screen, in pixels.
;  dx is the speed in the x-direction, in pixels/tick.
;  dy is the speed in the y-direction, in pixels/tick.

;  Examples of the data
(make-ball 7 2 -2 +1)
;  Another ball like the previous, but one tick later, if it doesn't hit anything.
(make-ball 5 3 -2 +1)
(make-ball 150 190 +1 -1)
;  Might be a ball at the start of the game, if it's a 300x200 field.
;
(check-expect (move-ball (make-ball 10 10 1 1)) 
              (make-ball 11 11 1 1))
(check-expect (move-ball (make-ball 100 100 -15 -15))
              (make-ball 85 85 -15 -15))
(check-expect (move-ball (make-ball 100 100 0 15))
              (make-ball 100 115 0 15))
(check-expect (move-ball (make-ball 100 100 15 0))
              (make-ball 115 100 15 0))
(check-expect (move-ball (make-ball 100 100 0 -15))
              (make-ball 100 85 0 -15))
(check-expect (move-ball (make-ball 100 100 -15 0))
              (make-ball 85 100 -15 0))
(check-expect (move-ball (make-ball 100 100 -15 15))
              (make-ball 85 115 -15 15))
(check-expect (move-ball (make-ball 100 100 15 -15))
              (make-ball 115 85 15 -15))
;
;  Signature:
;     move-ball: ball -> ball
;
;  Header:
;     (define (move-ball a-ball) ...)
;
;  Description:
;     Given a ball, return a new ball with x and y coordinates 
;     changed by the dx and dy amounts (respectively)
;
;  Body:
;     (define (move-ball a-ball) 99)
;
;  Completed Body:
(define (move-ball a-ball)
   (make-ball (+ (ball-x a-ball) (ball-dx a-ball)) 
              (+ (ball-y a-ball) (ball-dy a-ball)) 
              (ball-dx a-ball) 
              (ball-dy a-ball)))
;
;  Run tests:
;     All 8 tests passed!
;
;  Java:
#|
   public class Ball 
   {
    // Code for class Ball taken from hw03-soln-Breakout.java
    double x;   // The distance from the left edge of screen, in pixels.
    double y;   // The distance from the top  edge of screen, in pixels.
    double dx;  // The speed in the x-direction, in pixels/tick.
    double dy;  // The speed in the y-direction, in pixels/tick.
        
    
    Ball( double _x, double _y, double _dx, double _dy ) {
        this.x  =  _x;
        this.y  =  _y;
        this.dx = _dx;
        this.dy = _dy;
    }
    
    public double getX()
    {
    	return x;
    }
    
    public double getY()
    {
    	return y;
    }
    
    public double getDX()
    {
    	return dx;
    }
    
    public double getDY()
    {
    	return dy;
    }
    
    public static Ball move(Ball aBall)
    {
    	return new Ball(aBall.getX() + aBall.getDX(), 
                        aBall.getY() + aBall.getDY(), 
                        aBall.getDX(), 
                        aBall.getDY());
    }
}
|#
;
;;;; #2
;
;  a.
;    A direction is:
;       move-left
;       move-right
(define move-right 'right)
(define move-left 'left)
;
;    A paddle is:
;       x-coord
;       direction
;       speed (number > 0)
        (define-struct paddle (x a-dir speed))
;
;    Examples:
        (make-paddle 0 move-right 15)
        (make-paddle 200 move-left 10)
;
;
;    Template:
;
;    func-for-paddle : a-paddle -> ???
;    (define (func-for-paddle a-paddle)
;         ( ... (paddle-x a-paddle)
;           ... (paddle-a-dir a-paddle)
;           ... (paddle-speed a-paddle)))
;
;  b.
(check-expect (move-paddle (make-paddle 150 move-right 5)) (make-paddle 155 move-right 5))
(check-expect (move-paddle (make-paddle 150 move-left 5)) (make-paddle 145 move-left 5))
;
;    Signature:
;       move-paddle : paddle -> paddle
;
;    Header:
;       (define (move-paddle a-paddle) ...)
;
;    Description:
;       Given a paddle, move it 'speed' pixels to the 'direction'
;
;    Copy of template:
;      (define (func-for-paddle a-paddle)
;         ( ... (paddle-x-coord a-paddle)
;           ... (paddle-a-dir a-paddle)
;           ... (paddle-speed a-paddle)))
;
;    Body:
;      (define (move-paddle a-paddle)
;         ( ... (paddle-x-coord a-paddle)
;           ... (paddle-a-dir a-paddle)
;           ... (paddle-speed a-paddle)))
;
;    Completed body:
       (define (move-paddle a-paddle)
          (if (symbol=? (paddle-a-dir a-paddle) move-left)
              (make-paddle (- (paddle-x a-paddle) (paddle-speed a-paddle)) 
                           (paddle-a-dir a-paddle) 
                           (paddle-speed a-paddle))
              (make-paddle (+ (paddle-x a-paddle) (paddle-speed a-paddle)) 
                           (paddle-a-dir a-paddle)
                           (paddle-speed a-paddle))))
;
;    Run tests:
;      Both tests passed!
;
;  c.
;    Tests (these tests are relative to paddle-width (for these, assume a width of 20))
(check-expect (update-paddle (make-paddle 280 move-right 15)) (make-paddle 290 move-right 0))
(check-expect (update-paddle (make-paddle 250 move-right 85)) (make-paddle 290 move-right 0))
(check-expect (update-paddle (make-paddle 250 move-right 5)) (make-paddle 255 move-right 5))
(check-expect (update-paddle (make-paddle 25 move-left 15)) (make-paddle 10 move-left 0))
(check-expect (update-paddle (make-paddle 10 move-left 5)) (make-paddle 10 move-left 0))
(check-expect (update-paddle (make-paddle 50 move-left 115)) (make-paddle 10 move-left 0))
(check-expect (update-paddle (make-paddle 85 move-left 5)) (make-paddle 80 move-left 5))
;    The following test is awkward but the speed still being 5 at the left edge will be remedied on
;    the next update -
(check-expect (update-paddle (make-paddle 275 move-right 15)) (make-paddle 290 move-right 0))
;    
;
(define WORLD-WIDTH 300)
(define PADDLE-WIDTH 20)
;  Signature:
;     update-paddle: paddle -> paddle
;
;  Header:
;     (define (update-paddle a-paddle)) ... )
;
;  Description:
;     Given a paddle, check the bounds of the playable area to see 
;     how far the paddle can move with respect to the bounds
;
;  Copy of template:
;    (define (func-for-paddle a-paddle)
;        ( ... (paddle-x-coord a-paddle)
;          ... (paddle-a-dir a-paddle)
;          ... (paddle-speed a-paddle)))
;
;  Body:
;     (define (update-paddle a-paddle)
;         (if (symbol=? (paddle-a-dir a-paddle) left)
;             (make-paddle ( ... (- (paddle-x-coord a-paddle) (paddle-speed a-paddle)))
;                          (paddle-a-dir a-paddle) 
;                          (paddle-speed a-paddle))
;             (make-paddle ( ... (+ (paddle-x-coord a-paddle) (paddle-speed a-paddle))) 
;                          (paddle-a-dir a-paddle)
;                          (paddle-speed a-paddle))))
;
;  Completed body:
(define (update-paddle a-paddle)
    (if (symbol=? (paddle-a-dir a-paddle) move-left)
        (if (<= (- (paddle-x a-paddle) (paddle-speed a-paddle) (/ PADDLE-WIDTH 2)) 0) ;check for movable room
            (make-paddle (/ PADDLE-WIDTH 2) (paddle-a-dir a-paddle) 0) ;create paddle at left edge
            (move-paddle a-paddle)) ;otherwise move left normally
        (if (>= (+ (paddle-x a-paddle) (paddle-speed a-paddle)) (- WORLD-WIDTH (/ PADDLE-WIDTH 2))) ;check for movable room
            (make-paddle (- WORLD-WIDTH (/ PADDLE-WIDTH 2)) (paddle-a-dir a-paddle) 0) ;create paddle at right edge
            (move-paddle a-paddle)))) ;otherwise move right normally
;
;  Run tests:
;    All 9 tests passed!
;
;
;  d.
;    Data definition:
;       A keypress is:
;         "a" - for move-left
;         "d" - for move-right
;
;    Template:
;       (define (func-with-keypress a-key)
;           (cond [(key=? a-key "a") ... ]
;                 [(key=? a-key "d") ... ]))
;
;    Tests:
(check-expect (paddle-handle-key (make-paddle 55 move-left 10) "d") (make-paddle 55 move-right 11))
(check-expect (paddle-handle-key (make-paddle 233 move-right 11) "a") (make-paddle 233 move-left 12))
(check-expect (paddle-handle-key (make-paddle 233 move-left 12) "d") (make-paddle 233 move-right 12))
;
;    Signature:
;       paddle-handle-key: paddle keypress -> paddle
;
;    Header:
;       (define (paddle-handle-key a-paddle a-key) ... )
;
;    Description:
;       Given a paddle and a keypress, change the direction of the paddle
;       based on the keypress
;
;    Copy of template (amalgamation):
;       (define (func-with-keypress-and-paddle a-paddle a-key)
;           (cond [(key=? a-key "a") ( ... (paddle-x-coord a-paddle)
;                                      ... (paddle-speed a-paddle)) ]
;                 [(key=? a-key "d") ( ... (paddle-x-coord a-paddle)
;                                      ... (paddle-speed a-paddle)) ]))
;
;    Body:
;       (define (paddle-handle-key a-paddle a-key)
;           (cond [(key=? a-key "a") 99 ]
;                 [(key=? a-key "d") 99 ]))
;
;    Completed body:
        (define (paddle-handle-key a-paddle a-key)
            ;(cond [(key=? a-key "a") (make-paddle (paddle-x a-paddle) move-left (+ 3 (paddle-speed a-paddle)))]
                  ;[(key=? a-key "d") (make-paddle (paddle-x a-paddle) move-right (+ 3 (paddle-speed a-paddle)))]))
            (make-paddle (paddle-x a-paddle) 
                         (cond [(key=? a-key "a") move-left]
                               [(key=? a-key "d") move-right])
                         (+ (paddle-speed a-paddle) (if (< (paddle-speed a-paddle) 12) 1 0)))) 
;
;    Run tests:
;       Both tests passed!
;
;
;
;;;; #3
;
;    a.
;       Data definitions:
;          A brick is:
;            (make-brick ([real?] [real?] [image-color?]))
(define-struct brick (x y col))
;             x is the distance from the left edge of screen to the nw corner, in pixels.
;             y is the distance from the top  edge of screen to the nw corner, in pixels.
;             col is the color.
;             All bricks will have same size; we'll use a named-constant.

;             example:
(make-brick 50 10 'blue)
(make-brick 70 20 'red)
;
;             Template:
;               (define (func-for-brick a-brick)
;                   ( ... (brick-x a-brick)
;                     ... (brick-y a-brick)
;                     ... (brick-col a-brick)))
;
;    
;
;
;;;; #4
(define BRICK-WIDTH 20)
(define BRICK-HEIGHT 10)
; PADDLE-WIDTH 20   (from just above update-paddle)
(define PADDLE-HEIGHT 10)
(define PADDLE-Y 180)
(define PADDLE-COLOR 'black)
(define BALL-RADIUS 6)
(define BALL-COLOR 'red)
(define WORLD-HEIGHT 200)
(define brick-one (make-brick 35 30 'red))
(define paddle-one (make-paddle 40 move-right 10))
(define ball-one (make-ball 150 100 5 5))
(define rectangle-one (rectangle WORLD-WIDTH WORLD-HEIGHT "solid" 'gray))
;
;     a.
;        Tests:
(check-expect (draw-brick brick-one rectangle-one) 
              (place-image (rectangle 20 10 "solid" 'red) 
                           35 
                           30
                           (rectangle 300 200 "solid" 'gray)))
;
;        Signature:
;           draw-brick : brick, image -> image
;
;        Header:
;           (define (draw-brick a-brick an-image) ... )
;
;        Description:
;           Given a brick and an image, draw the brick on the image
;
;        Copy of template:
;           func-for-brick : brick -> ???
;           (define (func-for-brick a-brick)
;               ( ... (brick-x a-brick)
;                 ... (brick-y a-brick)
;                 ... (brick-col a-brick)))
;
;        Body:
;           (define (draw-brick a-brick an-image)
;               ( ... (brick-x a-brick)
;                 ... (brick-y a-brick)
;                 ... (brick-col a-brick)))
;
;        Completed body:
(define (draw-brick a-brick an-image)
    (place-image (rectangle BRICK-WIDTH BRICK-HEIGHT "solid" (brick-col a-brick))
                 (brick-x a-brick)
                 (brick-y a-brick)
                 an-image))
;
;        Run tests:
;          Test passed!
;
;     b.
;        Tests:
(check-expect (draw-paddle paddle-one rectangle-one) 
              (place-image (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" 'black) 
                           40 
                           180
                           rectangle-one))
;
;        Signature:
;           draw-paddle : paddle, image -> image
;
;        Header:
;           (define (draw-paddle a-paddle an-image) ... )
;
;        Description:
;           Given a paddle and an image, draw the paddle on the image
;
;        Copy of template:
;           func-for-paddle : a-paddle -> ???
;           (define (func-for-paddle a-paddle)
;              ( ... (paddle-x a-paddle)
;                ... (paddle-a-dir a-paddle)
;                ... (paddle-speed a-paddle)))
;
;        Body:
;           (define (draw-paddle a-paddle an-image)
;               ( ... (paddle-x a-paddle)))
;
;        Completed body:
(define (draw-paddle a-paddle an-image)
    (place-image (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" PADDLE-COLOR)
                 (paddle-x a-paddle)
                 PADDLE-Y
                 an-image))
;
;        Run tests:
;          Test passed!
;
;
;    d.
;        Tests:
(check-expect (draw-ball ball-one rectangle-one) 
              (place-image (circle BALL-RADIUS "solid" 'red) 
                           (ball-x ball-one) 
                           (ball-y ball-one)
                           rectangle-one))
;
;        Signature:
;           draw-ball : ball, image -> image
;
;        Header:
;           (define (draw-ball a-ball an-image) ... )
;
;        Description:
;           Given a ball and an image, draw the ball on the image
;
;        Copy of template:
;           func-for-paddle : a-ball -> ???
;           (define (func-for-ball a-ball)
;              ( ... (ball-x a-ball)
;                ... (ball-y a-ball)
;                ... (ball-dx a-ball)
;                ... (ball-dy a-ball)))
;
;        Body:
;           (define (draw-ball a-ball an-image)
;               ( ... (ball-x a-ball)
;                 ... (ball-y a-ball)))
;
;        Completed body:
(define (draw-ball a-ball an-image)
    (place-image (circle BALL-RADIUS "solid" BALL-COLOR)
                 (ball-x a-ball)
                 (ball-y a-ball)
                 an-image))
;
;        Run tests:
;          Test passed!
;
;
;    e.
;        Tests:
;(check-expect (draw-world world-one) 
;             (place-image (circle BALL-RADIUS "solid" BALL-COLOR)
;                           (ball-x (world-a-ball world-one))
;                           (ball-y (world-a-ball world-one))
;                           (place-image (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" PADDLE-COLOR)
;                                        (paddle-x (world-a-paddle world-one))
;                                        PADDLE-Y
;                                        (place-image (rectangle BRICK-WIDTH BRICK-HEIGHT "solid" (brick-col (world-a-brick world-one)))
;                                                     (brick-x (world-a-lob world-one))
;                                                     (brick-y (world-a-lob world-one))
;                                                     (empty-scene WORLD-WIDTH WORLD-HEIGHT)))))
;
;        Signature:
;           draw-world : world -> image
;
;        Header:
;           (define (draw-world a-world) ... )
;
;        Description:
;           Given a world, draw it onto an image
;
;        Copy of template:
;           func-for-world : world -> ???
;              (define (func-for-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-brick a-world))
;
;        Body:
;              (define (draw-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-brick a-world))
;
;        Completed body:
;(define (draw-world a-world)
;    (draw-ball (world-a-ball a-world) 
;               (draw-paddle (world-a-paddle a-world) 
;                            (draw-bricks (world-a-lob a-world) 
;                                        (empty-scene WORLD-WIDTH WORLD-HEIGHT)))))
;
;        Run tests:
;          Test passed!
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;HOMEWORK 5b STARTS HERE;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Collision detection from previous hw04 (minor refactor):
;    http://www.radford.edu/~itec380/2014fall-ibarland/Homeworks/hw04/hw04.html
;
;    Data definition:
;       A real rectangle is:
;          x
;          y
;          width
;          height
;          color
(define-struct real-rectangle (x y width height col))
;    Examples:
(make-real-rectangle 50 50 50 70 'black)
(make-real-rectangle 70 50 20 30 'red)
;    Template:
;       (define (func-for-real-rectangle a-real-rect)
;           ( ... (real-rectangle-x a-real-rect)
;             ... (real-rectangle-y a-real-rect)
;             ... (real-rectangle-width a-real-rect)
;             ... (real-rectangle-height a-real-rect)
;             ... (real-rectangle-col a-real-rect)))
;    Tests:
;       blatant collision or lack-thereof
(check-expect (real-rect-collider (make-real-rectangle 50 50 70 50 'black) (make-real-rectangle 45 45 10 10 'red)) true)
(check-expect (real-rect-collider (make-real-rectangle 50 50 70 50 'black) (make-real-rectangle 130 50 70 50 'green)) false)
;       an entire side
(check-expect (real-rect-collider (make-real-rectangle 20 20 30 20 'blue) (make-real-rectangle 50 20 30 20 'purple)) true)
;       1-pixel-wide gap
(check-expect (real-rect-collider (make-real-rectangle 20 20 30 20 'red) (make-real-rectangle 51 20 30 20 'black)) false)
;       a single pixel
(check-expect (real-rect-collider (make-real-rectangle 20 20 30 20 'green) (make-real-rectangle 50 40 30 20 'red)) true)
;
;    Signature:
;       real-rect-collider : a real rectangle, a real rectangle --> boolean
;
;    Header: 
;       (define (real-rect-collider a-real-rect-one a-real-rect-two) ... )
;
;    Description:
;       Given two real rectangles, return true if they overlap, false if they do not
;
;    Copy of template (adapted):
;       (define (func-for-real-rectangle a-real-rect-one a-real-rect-two)
;           ( ... (real-rectangle-x a-real-rect-one)
;             ... (real-rectangle-y a-real-rect-one)
;             ... (real-rectangle-width a-real-rect-one)
;             ... (real-rectangle-height a-real-rect-one)
;             ... (real-rectangle-x a-real-rect-two)
;             ... (real-rectangle-y a-real-rect-two)
;             ... (real-rectangle-width a-real-rect-two)
;             ... (real-rectangle-height a-real-rect-two)
;
;    Completed body:
;       Received help from: 
;            https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
(define (real-rect-collider a-real-rect-one a-real-rect-two)
   (and (<= (real-rectangle-x a-real-rect-one) 
            (+ (real-rectangle-width a-real-rect-two) (real-rectangle-x a-real-rect-two)))
        (<= (real-rectangle-x a-real-rect-two) 
            (+ (real-rectangle-width a-real-rect-one) (real-rectangle-x a-real-rect-one)))
        (<= (real-rectangle-y a-real-rect-one) 
            (+ (real-rectangle-height a-real-rect-two) (real-rectangle-y a-real-rect-two)))
        (<= (real-rectangle-y a-real-rect-two) 
            (+ (real-rectangle-height a-real-rect-one) (real-rectangle-y a-real-rect-one)))))
;
;     Run tests:
;        All 5 tests passed!
;
;

;;;; #4
;
;  A list-of-bricks (lob) is:
;    empty, OR
;    (make-cons [brick] [list-of-bricks])
;
;  Examples of list-of-bricks:
empty
(cons (make-brick 20 20 'red) empty)
(define two-bricks (cons (make-brick 20 20 'blue) (cons (make-brick 45 20 'green) empty)))
(cons (make-brick 20 20 'purple) 
      (cons (make-brick 45 20 'black) 
            (cons (make-brick 70 20 'red) empty)))
(define tons-of-bricks 
    (cons (make-brick 20 20 'purple) 
          (cons (make-brick 45 20 'black) 
                (cons (make-brick 70 20 'red) 
                      (cons (make-brick 95 20 'blue) 
                            (cons (make-brick 120 20 'green)
                                  (cons (make-brick 145 20 'black) empty)))))))
;
;  Template for list-of-bricks functions:
;    func-for-lob : list-of-bricks -> ???
;    (define (func-for-lob a-lob)
;        (cond [(empty? a-lob) ... ]
;              [(cons? a-lob) ( ... (first a-lob)
;                               ... (func-for-lob (rest a-lob)))]))
;
;
;;;; #5
;
;  Tests:
(check-expect (draw-bricks two-bricks (empty-scene WORLD-WIDTH WORLD-HEIGHT))
      (place-image (rectangle BRICK-WIDTH BRICK-HEIGHT "solid" 'blue)
                   20
                   20
                   (place-image (rectangle BRICK-WIDTH BRICK-HEIGHT "solid" 'green)
                                45
                                20
                                (empty-scene WORLD-WIDTH WORLD-HEIGHT))))
;
(check-expect (draw-bricks two-bricks (empty-scene WORLD-WIDTH WORLD-HEIGHT))
              (draw-brick (make-brick 20 20 'blue) 
                          (draw-brick (make-brick 45 20 'green) 
                                      (empty-scene WORLD-WIDTH WORLD-HEIGHT))))
;
;  Signature:
;     draw-bricks : list-of-bricks, image -> image
;
;  Header:
;     (define (draw-bricks a-lob an-image) ... )
;
;  Description:
;     Given a 'list-of-bricks', draw each brick on 'an-image'
;
;  Copy of template:
;    func-for-lob : a-lob -> ???
;    (define (func-for-lob a-lob)
;        (cond [(empty? a-lob) ... ]
;              [(cons? a-lob) ( ... (first a-lob)
;                               ... (func-for-lob (rest a-lob)))]))
;
;  Body:
;   (define (draw-bricks a-lob an-image)
;       (cond [(empty? a-lob) empty-image]
;              [(cons? a-lob) ( ... (first a-lob)
;                               ... (draw-bricks (rest a-lob) an-image))]))
;
;  Completed body:
(define (draw-bricks a-lob an-image)
     (cond [(empty? a-lob) an-image]
           [(cons? a-lob) (draw-bricks (rest a-lob) (draw-brick (first a-lob) an-image))]))
;
;
;;;; #6
;
;
;          A world is:
;             ball
;             paddle
;             list-of-bricks
;             (make-world ([ball] [paddle] [list-of-bricks])
(define-struct world (a-ball a-paddle a-lob))

;          Examples:
(define world-one (make-world (make-ball 150 100 3 3) (make-paddle 125 move-left 10) 
                              (cons (make-brick 20 20 'blue) 
                                    (cons (make-brick 45 20 'green) empty))))
(define world-two (make-world (make-ball 50 75 5 1) (make-paddle 30 move-right 20) 
                              (cons (make-brick 20 20 'blue) 
                                    (cons (make-brick 45 20 'green) empty))))
;          The following examples are for paddle-related testing
(define worlds-end-one (make-world (make-ball 50 75 1 1) 
                                   (make-paddle 15 move-left 40) 
                                   (cons (make-brick 20 20 'blue) 
                                         (cons (make-brick 45 20 'green) empty))))
(define worlds-end-two (make-world (make-ball 50 75 1 1) 
                                   (make-paddle 275 move-right 5) 
                                   (cons (make-brick 20 20 'blue) 
                                         (cons (make-brick 45 20 'green) empty))))
;
;          template:
;             (define (func-for-world a-world)
;                 ( ... (world-a-ball a-world)
;                   ... (world-a-paddle a-world)
;                   ... (world-a-lob a-world))
;
;
(check-expect (world-handle-key world-one "a" ) 
              (make-world (world-a-ball world-one) 
                          (paddle-handle-key (world-a-paddle world-one) "a") 
                          (world-a-lob world-one)))
;
(check-expect (world-handle-key world-two "a") 
              (make-world (world-a-ball world-two) 
                          (paddle-handle-key (world-a-paddle world-two) "a") 
                          (world-a-lob world-two)))
;
(check-expect (world-handle-key worlds-end-one "a") 
              (make-world (world-a-ball worlds-end-one) 
                          (paddle-handle-key (world-a-paddle worlds-end-one) "a") 
                          (world-a-lob worlds-end-one)))
;
(check-expect (world-handle-key worlds-end-two "a") 
              (make-world (world-a-ball worlds-end-two)
                          (paddle-handle-key (world-a-paddle worlds-end-two) "a") 
                          (world-a-lob worlds-end-two)))
;
(check-expect (world-handle-key world-one "d" ) 
              (make-world (world-a-ball world-one)
                          (paddle-handle-key (world-a-paddle world-one) "d") 
                          (world-a-lob world-one)))
;
(check-expect (world-handle-key world-two "d") 
              (make-world (world-a-ball world-two) 
                          (paddle-handle-key (world-a-paddle world-two) "d") 
                          (world-a-lob world-two)))
;
(check-expect (world-handle-key worlds-end-one "d") 
              (make-world (world-a-ball worlds-end-one) 
                          (paddle-handle-key (world-a-paddle worlds-end-one) "d") 
                          (world-a-lob worlds-end-one)))
;
(check-expect (world-handle-key worlds-end-two "d") 
              (make-world (world-a-ball worlds-end-two)
                          (paddle-handle-key (world-a-paddle worlds-end-two) "d") 
                          (world-a-lob worlds-end-two)))
;
;        Signature:
;            world-handle-key : world, keypress -> world
;
;        Header:
;           (define (world-handle-key a-world a-key) ... )
;
;        Description:
;           Takes in a world and returns a new world one "tick" later (based on the keypress)
;
;        Copy of template:
;           template:
;              (define (func-for-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-lob a-world))
;
;        Body:
;            (define (world-handle-key a-world a-key)
;                (make-world ... (world-a-ball a-world)
;                            ... (world-a-paddle a-world)
;                            ... (world-a-lob a-world))
;
;        Completed body:
             (define (world-handle-key a-world a-key)
                (make-world (world-a-ball a-world)
                            (paddle-handle-key (world-a-paddle a-world) a-key) 
                            (world-a-lob a-world)))
;
;        Run tests:
;            All 8 tests passed!
;
;
;
;
;;;; #7
;
; brick-collide-ball? : brick, ball -> boolean
(check-expect (brick-collide-ball? (make-brick 20 20 'red) (make-ball 25 25 5 5)) true)
(check-expect (brick-collide-ball? (make-brick 20 20 'red) (make-ball 50 50 3 11)) false)
;
; Signature:
;    brick-collide-ball? : brick, ball -> boolean
;
; Header:
;   (define (brick-collide-ball? a-brick a-ball) ... )
;
; Description:
;   Given a brick and a ball, determine if they overlap
;
; Copy of template(s):
;   func-for-ball : a-ball -> ???
;   (define (func-for-ball a-ball)
;       ( ... (ball-x a-ball)
;         ... (ball-y a-ball)
;         ... (ball-dx a-ball)
;         ... (ball-dy a-ball)))
;
;   func-for-brick: a-brick -> ???
;   (define (func-for-brick a-brick)
;       ( ... (brick-x a-brick)
;         ... (brick-y a-brick)
;         ... (brick-col a-brick)))
;
; Body:
;   (define (brick-collide-ball? a-brick a-ball)
;       ( ... (ball-x a-ball)
;         ... (ball-y a-ball)
;         ... (brick-x a-brick)
;         ... (brick-y a-brick)
;         ... (brick-col a-brick)))
;
; Completed body:
(define (brick-collide-ball? a-brick a-ball)
    (real-rect-collider (make-real-rectangle (- (brick-x a-brick) (/ BRICK-WIDTH 2))
                                             (- (brick-y a-brick) (/ BRICK-HEIGHT 2))
                                             BRICK-WIDTH 
                                             BRICK-HEIGHT 
                                             (brick-col a-brick)) 
                        (make-real-rectangle (- (ball-x a-ball) (/ BALL-RADIUS 2))
                                             (- (ball-y a-ball) (/ BALL-RADIUS 2))
                                             BALL-RADIUS
                                             BALL-RADIUS 
                                             BALL-COLOR)))
;
;  Run tests:
;    Both tests passed!
;
;;;; #8
; 
;  Tests:
(check-expect (bricks-remaining two-bricks (make-ball 15 15 5 5)) 
              (cons (make-brick 45 20 'green) empty))
(check-expect (bricks-remaining (cons (make-brick 20 20 'red) 
                                      (cons (make-brick 40 20 'blue) empty)) 
                                (make-ball 35 15 5 5)) 
              (cons (make-brick 20 20 'red) empty))
(check-expect (bricks-remaining (cons (make-brick 20 20 'blue) 
                                      (cons (make-brick 60 20 'green) 
                                            (cons (make-brick 80 20 'black) empty))) 
                                (make-ball 70 15 5 5)) 
              (cons (make-brick 20 20 'blue) empty))
;
;  Signature:
;    bricks-remaining : list-of-bricks, ball -> list-of-bricks
;
;  Header:
;    (define (bricks-remaining a-lob a-ball) ... )
;
;  Description:
;    Given a list-of-bricks (a-lob) and a ball (a-ball), return a list-of-bricks composed
;    only of bricks that did NOT collide with the ball
;
;  Copy of template(s):
;    func-for-lob : a-lob -> ???
;    (define (func-for-lob a-lob)
;        (cond [(empty? a-lob) ... ]
;              [(cons? a-lob) ( ... (first a-lob)
;                               ... (func-for-lob (rest a-lob)))]))
;
;    func-for-ball : a-ball -> ???
;    (define (func-for-ball a-ball)
;        ( ... (ball-x a-ball)
;          ... (ball-y a-ball)
;          ... (ball-dx a-ball)
;          ... (ball-dy a-ball)))
;
;  Body:
;    (define (bricks-remaining a-lob a-ball)
;        (cond [(empty? a-lob) empty]
;              [(cons? a-lob) ( ... (first a-lob)
;                               ... (func-for-lob (rest a-lob)))]))
;
;  Completed body:
(define (bricks-remaining a-lob a-ball)
    (cond [(empty? a-lob) empty]
          [(cons? a-lob) (if (brick-collide-ball? (first a-lob) a-ball)
                             (bricks-remaining (rest a-lob) a-ball)
                             (cons (first a-lob) (bricks-remaining (rest a-lob) a-ball)))]))
; NOTE -------- I tried to refactor the bricks-remaining code many times but always ended up
;      -------- with undesirable results like:
;      --------     (cons empty empty)
;      --------     (cons empty (cons (make-brick x y col) empty))
;
;  Run tests:
;    All 3 tests passed!
;
;
;;;; #9
;
;   a.
;
;      Tests:
(check-expect (reflect-ball-vertically (make-real-rectangle 20 10 300 1 'black) 
                                         (make-ball 20 10 5 5)) 
              (make-ball 20 10 5 -5))
(check-expect (reflect-ball-vertically (make-real-rectangle 50 100 20 10 'blue)
                                         (make-ball 225 100 5 5)) 
              (make-ball 225 100 5 5))
;
;      Signature:
;         reflect-ball-horizontally : real-rectangle, ball -> ball
;
;      Header:
;         (define (reflect-ball-horizontally a-real-rect a-ball) ... )
;
;      Description:
;         Given a-real-rectangle and a-ball, detect a collision and return a new ball 
;         with updated dy ((* -1) if collision is true, (* 1) otherwise)
;
;      Copy of template(s):
;         func-for-real-rectangle: a-real-rectangle -> ???
;         (define (func-for-real-rectangle a-real-rect)
;             ( ... (real-rectangle-x a-real-rect)
;               ... (real-rectangle-y a-real-rect)
;               ... (real-rectangle-width a-real-rect)
;               ... (real-rectangle-height a-real-rect)
;               ... (real-rectangle-col a-real-rect)))
;
;         func-for-ball: a-ball -> ???
;         (define (func-for-ball a-ball)
;             ( ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;
;      Body:
;         (define (reflect-ball-horizontally a-real-rect a-ball)
;             ( ... (real-rectangle-x a-real-rect)
;               ... (real-rectangle-y a-real-rect)
;               ... (real-rectangle-width a-real-rect)
;               ... (real-rectangle-height a-real-rect)
;               ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;           
;      Completed body:
         (define (reflect-ball-vertically a-real-rect a-ball)
             (if (real-rect-collider a-real-rect 
                                     (make-real-rectangle (- (ball-x a-ball) (/ BALL-RADIUS 2))
                                                          (- (ball-y a-ball) (/ BALL-RADIUS 2))
                                                          BALL-RADIUS
                                                          BALL-RADIUS 
                                                          BALL-COLOR))
                 (make-ball (ball-x a-ball) 
                            (ball-y a-ball) 
                            (ball-dx a-ball) 
                            (* -1 (ball-dy a-ball)))
                 a-ball))
;
;
;   b.
;      Tests:
(check-expect (reflect-ball-off-brick (make-brick 20 20 'gray) (make-ball 30 25 5 5)) 
              (make-ball 30 25 5 -5))
(check-expect (reflect-ball-off-brick (make-brick 40 70 'orange) (make-ball 20 10 5 5)) 
              (make-ball 20 10 5 5))
;
;      Signature:
;         reflect-ball-off-brick: brick, ball -> ball
;
;      Header:
;         (define (reflect-ball-off-brick a-brick a-ball) ... )
;
;      Description:
;         Given a brick and a ball, multiply the ball's 'dy' by -1 if it collides with the brick
;
;      Copy of template(s):
;         func-for-brick: a-brick -> ???
;         (define (func-for-brick a-brick)
;             ( ... (brick-x a-brick)
;               ... (brick-y a-brick)
;               ... (brick-col a-brick)))
;
;         func-for-ball: a-ball -> ???
;         (define (func-for-ball a-ball)
;             ( ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;
;       Body:
;          (define (reflect-ball-off-brick a-brick a-ball)
;              ( ... (brick-x a-brick)
;                ... (brick-y a-brick)
;                ... (brick-col a-brick)
;                ... (ball-x a-ball)
;                ... (ball-y a-ball)
;                ... (ball-dx a-ball)
;                ... (ball-dy a-ball)))
;       Completed body:
(define (reflect-ball-off-brick a-brick a-ball)
   (reflect-ball-vertically (make-real-rectangle (- (brick-x a-brick) (/ BRICK-WIDTH 2))
                                                 (- (brick-y a-brick) (/ BRICK-HEIGHT 2))
                                                 BRICK-WIDTH 
                                                 BRICK-HEIGHT 
                                                 (brick-col a-brick)) 
                             a-ball))
;
;   b.
;      Tests:
(check-expect (reflect-ball-off-paddle (make-paddle 150 move-left 12) (make-ball 145 175 5 5)) 
              (make-ball 145 175 5 -5))
(check-expect (reflect-ball-off-paddle (make-paddle 25 move-right 6) (make-ball 20 10 5 5)) 
              (make-ball 20 10 5 5))
;
;      Signature:
;         reflect-ball-off-paddle : paddle, ball -> ball
;
;      Header:
;         (define (reflect-ball-off-paddle a-paddle a-ball) ... )
;
;      Description:
;         Given 'a-paddle' and 'a-ball', multiply the ball's 'dy' by -1 if it collides 
;         with the paddle
;
;      Copy of template(s):
;         func-for-paddle : a-paddle -> ???
;         (define (func-for-paddle a-paddle)
;             ( ... (paddle-x a-paddle)
;               ... (paddle-a-dir a-paddle)
;               ... (paddle-speed a-paddle)))
;
;         func-for-ball: a-ball -> ???
;         (define (func-for-ball a-ball)
;             ( ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;
;      Body:
;         (define (reflect-ball-off-paddle a-paddle a-ball)
;             (reflect-ball-horizontally ( ... (paddle-x a-paddle)
;                                          ... (paddle-a-dir a-paddle)
;                                          ... (paddle-speed a-paddle)))
;                                          ... (ball-x a-ball)
;                                          ... (ball-y a-ball)
;                                          ... (ball-dx a-ball)
;                                          ... (ball-dy a-ball))))
;
;      Completed body:
(define (reflect-ball-off-paddle a-paddle a-ball)
   (reflect-ball-vertically (make-real-rectangle (- (paddle-x a-paddle) (/ PADDLE-WIDTH 2))
                                                 (- PADDLE-Y (/ PADDLE-HEIGHT 2))
                                                 PADDLE-WIDTH 
                                                 PADDLE-HEIGHT
                                                 PADDLE-COLOR)
                              a-ball))
;         
;
;;;; #10
;
;   Tests:
(check-expect (reflect-ball-off-bricks two-bricks (make-ball 15 15 5 5)) 
              (make-ball 15 15 5 -5))
(check-expect (reflect-ball-off-bricks (cons (make-brick 20 20 'red) 
                                             (cons (make-brick 40 20 'blue) empty))
                                       (make-ball 30 20 5 5))
              (make-ball 30 20 5 5))
(check-expect (reflect-ball-off-bricks tons-of-bricks (make-ball 150 100 5 5)) 
              (make-ball 150 100 5 5))
;
;   Signature:
;     reflect-ball-off-bricks : list-of-bricks, ball -> ball
;
;   Header:
;     (define (reflect-ball-off-bricks a-lob a-ball) ... )
;
;   Description:
;     Given a list of bricks (a-lob) and 'a-ball', detect if the ball is colliding off any 
;     of the bricks in the list, if so: multiply the ball's 'dy' by -1
;
;   Copy of template(s):
;      func-for-lob : list-of-bricks -> ???
;      (define (func-for-lob a-lob)
;          (cond [(empty? a-lob) ... ]
;                [(cons? a-lob) ( ... (first a-lob)
;                                 ... (func-for-lob (rest a-lob)))]))
;
;      func-for-ball: a-ball -> ???
;      (define (func-for-ball a-ball)
;          ( ... (ball-x a-ball)
;            ... (ball-y a-ball)
;            ... (ball-dx a-ball)
;            ... (ball-dy a-ball)))
;
;   Body:
;      (define (reflect-ball-off-bricks a-lob a-ball)
;          (cond [(empty? a-lob) a-ball]
;                [(cons? a-lob) ( ... (first a-lob)
;                                 ... (reflect-ball-off-bricks (rest a-lob) a-ball))]))
;
;   Completed body:
(define (reflect-ball-off-bricks a-lob a-ball)
   (cond [(empty? a-lob) a-ball]
         [(cons? a-lob) (reflect-ball-off-bricks (rest a-lob) 
                                                 (reflect-ball-off-brick (first a-lob) a-ball))]))
;
;  Run tests:
;    Both tests passed!
;
;
;;;; #11
;
;   Helper:
(define ceiling-rect (make-real-rectangle 0 1 300 2 'white))
(define left-side-rect (make-real-rectangle 1 0 2 200 'white))
(define right-side-rect (make-real-rectangle 300 0 2 200 'white))
;     Tests:
(check-expect (ball-collide-boundaries (make-ball 150 0 5 5)) (make-ball 150 0 5 -5))
(check-expect (ball-collide-boundaries (make-ball 150 100 5 5)) (make-ball 150 100 5 5))
(check-expect (ball-collide-boundaries (make-ball 0 0 5 5)) (make-ball 0 0 -5 -5))
(check-expect (ball-collide-boundaries (make-ball 0 100 5 5)) (make-ball 0 100 -5 5))
;
;     Signature:
;        ball-collide-boundaries : a-ball -> a-ball
;
;     Header:
;        (define (ball-collide-boundaries a-ball) ... )
;
;     Description:
;        Given a ball, see if it collides with the game window's boundaries
;
;     Copy of template(s):
;         func-for-ball: a-ball -> ???
;         (define (func-for-ball a-ball)
;             ( ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;
;     Body:
;        (define (ball-collide-boundaries a-ball)
;             ( ... (ball-x a-ball)
;               ... (ball-y a-ball)
;               ... (ball-dx a-ball)
;               ... (ball-dy a-ball)))
;
;     Completed body:
(define (ball-collide-boundaries a-ball)
     (let* {[ball-bounds (make-real-rectangle (- (ball-x a-ball) (/ BALL-RADIUS 2))
                                              (- (ball-y a-ball) (/ BALL-RADIUS 2))
                                              BALL-RADIUS
                                              BALL-RADIUS 
                                              BALL-COLOR)]}
           (make-ball (ball-x a-ball) 
                      (ball-y a-ball)
                      (if (or (real-rect-collider ball-bounds left-side-rect)
                              (real-rect-collider ball-bounds right-side-rect))
                          (* (ball-dx a-ball) -1)
                          (ball-dx a-ball))
                      (if (real-rect-collider ball-bounds ceiling-rect)
                          (* (ball-dy a-ball) -1)
                          (ball-dy a-ball)))))
;     Run tests:
;        All 4 tests passed!
;
;
;   Tests
;
;   Signature:
;      update-ball : world -> ball
;
;   Header:
;      (define (update-ball a-world) ... )
;
;   Description:
;      Given a world, tests the world's ball's collision and moves accordingly
;
;   Copy of template(s):
;      func-for-world : world -> ???
;         (define (func-for-world a-world)
;             ( ... (world-a-ball a-world)
;               ... (world-a-paddle a-world)
;               ... (world-a-lob a-world))
;
;   Body:
;      (define (update-ball a-world)
;          ( ... (world-a-ball a-world)
;            ... (world-a-paddle a-world)
;            ... (world-a-lob a-world))
;
;   Completed body:
(define (update-ball a-world)
   (move-ball (reflect-ball-off-paddle 
                     (world-a-paddle a-world)
                     (reflect-ball-off-bricks (world-a-lob a-world) 
                                              (ball-collide-boundaries (world-a-ball a-world))))))
;
;
;
;        Tests:
(check-expect (update-world world-one) 
              (make-world (update-ball world-one)
                          (update-paddle (world-a-paddle world-one)) 
                          (world-a-lob world-one)))
;
(check-expect (update-world world-two) 
              (make-world (update-ball world-two)
                          (update-paddle (world-a-paddle world-two)) 
                          (world-a-lob world-two)))
;
(check-expect (update-world worlds-end-one) 
              (make-world (update-ball worlds-end-one) 
                          (update-paddle (world-a-paddle worlds-end-one)) 
                          (world-a-lob worlds-end-one)))
;
(check-expect (update-world worlds-end-two) 
              (make-world (update-ball worlds-end-two)
                          (update-paddle (world-a-paddle worlds-end-two)) 
                          (world-a-lob worlds-end-two)))
;
;        Signature:
;            update-world : world -> world
;
;        Header:
;           (define (update-world a-world) ... )
;
;        Description:
;           Takes in a world and returns a new world one "tick" later
;
;        Copy of template:
;           template:
;              (define (func-for-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-lob a-world))
;
;        Body:
;            (define (update-world a-world)
;                (make-world ... (world-a-ball a-world)
;                            ... (world-a-paddle a-world)
;                            ... (world-a-lob a-world))
;
;        Completed body:
             (define (update-world a-world)
                 (make-world (update-ball a-world)
                             (update-paddle (world-a-paddle a-world))
                             (bricks-remaining (world-a-lob a-world) (world-a-ball a-world))))
;
;        Run tests:
;            All 4 tests passed!
;
;
;
;        Tests:
(check-expect (draw-world world-one) 
              (place-image (circle BALL-RADIUS "solid" BALL-COLOR)
                           (ball-x (world-a-ball world-one))
                           (ball-y (world-a-ball world-one))
                           (place-image (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" PADDLE-COLOR)
                                        (paddle-x (world-a-paddle world-one))
                                        PADDLE-Y
                                        (draw-bricks (world-a-lob world-one) 
                                                     (empty-scene WORLD-WIDTH WORLD-HEIGHT)))))
;
;        Signature:
;           draw-world : world -> image
;
;        Header:
;           (define (draw-world a-world) ... )
;
;        Description:
;           Given a world, draw it onto an image
;
;        Copy of template:
;           func-for-world : world -> ???
;              (define (func-for-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-lob a-world))
;
;        Body:
;              (define (draw-world a-world)
;                  ( ... (world-a-ball a-world)
;                    ... (world-a-paddle a-world)
;                    ... (world-a-lob a-world))
;
;        Completed body:
(define (draw-world a-world)
    (draw-ball (world-a-ball a-world) 
               (draw-paddle (world-a-paddle a-world) 
                            (draw-bricks (world-a-lob a-world) 
                                         (empty-scene WORLD-WIDTH WORLD-HEIGHT)))))
;
;        Run tests:
;          Test passed!
;
(define breakout (make-world (make-ball 150 50 3 3) 
                                   (make-paddle 275 move-right 5) 
                                   tons-of-bricks))
;
;(big-bang breakout
;       [on-key  world-handle-key]
;        [on-tick update-world]
;        [to-draw draw-world]
;        [stop-when (λ (w) (or (> (ball-y (world-a-ball breakout)) WORLD-HEIGHT) 
;                              (empty? (world-a-lob breakout))))])