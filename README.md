# CustomCollectionViewLayout
Custom `UICollectionViewLayout` that demonstrates how cells can invalidate proposed layout attributes and a custom layout that can enter a shorter display mode when space becomes short.


## How it works

Little sample project that displays tags with random names. Special behaviors to be seen here:

- Custom `UICollectionViewLayout` similar to FlowLayout but Left-Aligned
- Custom `UICollectionViewCell` that returns preferred attributes to fit it's content
	- The collection view layout handles this by running a second layout pass
- Custom `UICollectionViewLayoutAttributes` to pass additional metadata between layout and cells
	- Layout request cells to show a shorted label when not all cells fit visible area
	- Cellas handle the custom attribute and update accordingly
	- The collection view layout handles this by running a third layout pass


## Images

I know you love images. I do as well. So here are some:

Left-aligned layout with cells fitting their size:
![](http://cl.ly/fJNj/image4.23.png)

If space gets constrained, cells switch to shorted display:
![](http://cl.ly/fJG0/image4.32.png)

If even more get added, view starts to scroll:
![](http://cl.ly/fJ2y/image5.13.png)


## Known Issues

There are a few edge cases where things do not behave as they should. Especially when adding or removing cells. I'm not sure, however, if this is my fault or the frameworks. I've tried long enough to fix them that I'm leaning towards the latter (buggy framework) though…