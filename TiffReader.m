function subimages = TiffReader(filename)

    t = Tiff(filename, 'r');
    subimages(:, :, 1) = t.read();
    
    if t.lastDirectory()
        return;
    end
    
    t.nextDirectory();
    
    while true
        subimages(:, :, end+1) = t.read();
        if t.lastDirectory()
            break;
        else
            t.nextDirectory();
        end
    end

end