use std::time::Duration;

use opencv::{
    core::{CV_8UC3, Scalar},
    highgui,
};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ctx = r2r::Context::create()?;
    let mut node = r2r::Node::create(ctx, "ros2_opencv", "")?;

    let mat = opencv::core::Mat::new_rows_cols_with_default(400, 400, CV_8UC3, Scalar::all(120.0))
        .expect("Failed to create Mat");
    loop {
        highgui::imshow("r2r_opencv", &mat).expect("Failed to show image");
        highgui::wait_key(100).expect("Failed to wait for key");
        node.spin_once(Duration::from_secs_f32(0.1));
    }
}
